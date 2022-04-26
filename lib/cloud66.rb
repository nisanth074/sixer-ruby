# Move env vars from Cloud 66 "SupportBee" stack's "staging" environment to "SupportBee Maestro" stack's staging environment

require "json"
require "httparty"
require "active_support"
require "pry"

require "active_support/core_ext/string/inflections"

require_relative "cloud66/resource"
require_relative "cloud66/resource_collection"
require_relative "cloud66/all_resources"

require_relative "cloud66/environment_variable"
require_relative "cloud66/environment_variables"
require_relative "cloud66/all_environment_variables"

class Cloud66
  class Error < StandardError
    def context
      @context ||= {}
    end
  end

  class UnsuccessfulResponse < Error
    def response
      context[:response]
    end
  end

  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def get(path, params = {})
    response = HTTParty.get("#{base_url}#{path}", headers: get_headers, query: params)
    unless response.success?
      e = Cloud66::UnsuccessfulResponse.new
      e.context[:response] = response
      raise e
    end

    response
  end

  def post(path, body_hash = {})
    HTTParty.post("#{base_url}#{path}", headers: post_headers, body: body_hash.to_json)
  end

  def base_url
    "https://app.cloud66.com/api/3"
  end

  def authorization_headers
    {
      "Authorization": "Bearer #{access_token}"
    }
  end

  def get_headers
    {
      "Accept" => "application/json"
    }.merge(authorization_headers)
  end

  def post_headers
    {
      "Content-Type" => "application/json"
    }.merge(authorization_headers)
  end

  def stack_env_vars(stack_id)
    EnvironmentVariables.new(self, stack_id)
  end
end
