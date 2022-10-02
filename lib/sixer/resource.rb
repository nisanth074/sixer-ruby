class Sixer
  class Resource
    class << self
      def retrieve(parent, id, params = {})
        properties = { "id" => id }
        new(parent, properties).retrieve(params)
      end
    end

    attr_reader :parent,
                :properties,
                :params,
                :response

    def initialize(parent, properties = {})
      @parent, @properties = parent, properties
    end

    def retrieve(params = {})
      @response = sixer.get(path, params)
      @properties = JSON.parse(response.body)
      @params = params
      @retrieved = true

      self
    end

    def retrieve_unless_retrieved
      retrieve unless @retrieved
    end

    def name
      self.class.to_s.demodulized.underscore
    end

    def path
      "#{parent.path}/#{name}/#{id}"
    end

    def sixer
      parent.sixer
    end
  end
end
