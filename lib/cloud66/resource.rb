class Cloud66
  class Resource
    class << self
      def retrieve(cloud66, id, params = {})
        properties = { "id" => id }
        new(cloud66, properties).retrieve(params)
      end
    end

    attr_reader :cloud66,
                :params,
                :properties,
                :response

    def initialize(cloud66, properties = {})
      @cloud66, @properties = cloud66, properties
    end

    def retrieve(params = {})
      @response = cloud66.get(path, params)
      @properties = JSON.parse(response.body)
      @params = params
      self
    end
  end
end
