# Move env vars from Cloud 66 "SupportBee" stack's "staging" environment to "SupportBee Maestro" stack's staging environment

require "json"
require "httparty"
require "active_support"
require "active_support/core_ext/string/inflections"
# require "pry"

require_relative "sixer/resource"
require_relative "sixer/resource_collection"
require_relative "sixer/all"

resources = %w(
  stack
  environment_variable
)
resources.each do |resource|
  require_relative "sixer/#{resource}"
  require_relative "sixer/#{resource}_collection"
end

class Sixer
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
      e = Sixer::UnsuccessfulResponse.new
      e.context[:response] = response
      raise e
    end

    response
  end

  def post(path, body_hash = {})
    HTTParty.post("#{base_url}#{path}", headers: post_headers, body: body_hash.to_json)
  end

  def base_url
    "https://app.sixer.com/api/3"
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

  def sixer
    self
  end

  def path
    ""
  end
end
