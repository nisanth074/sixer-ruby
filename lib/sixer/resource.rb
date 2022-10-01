class Sixer
  class Resource
    class << self
      def retrieve(sixer, id, params = {})
        properties = { "id" => id }
        new(sixer, properties).retrieve(params)
      end
    end

    attr_reader :sixer,
                :params,
                :properties,
                :response

    def initialize(sixer, properties = {})
      @sixer, @properties = sixer, properties
    end

    def retrieve(params = {})
      @response = sixer.get(path, params)
      @properties = JSON.parse(response.body)
      @params = params
      self
    end
  end
end
