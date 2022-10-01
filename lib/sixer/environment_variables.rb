class Sixer
  class EnvironmentVariables < ResourceCollection
    class << self
      def retrieve(sixer, stack_id, params = {})
        resource_collection = new(sixer, stack_id)
        resource_collection.retrieve(params)
      end
    end

    attr_reader :stack_id

    def initialize(sixer, stack_id, properties = {})
      @stack_id = stack_id
      super(sixer, properties)
    end

    def path
      stack_path + "/environments"
    end

    def stack_path
      "/stacks/#{stack_id}"
    end

    def next_page
      new_params = params.merge({ "page" => (page_number + 1) })
      self.class.retrieve(sixer, stack_id, new_params)
    end
  end
end
