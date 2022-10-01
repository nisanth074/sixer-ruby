class Sixer
  class ResourceCollection < Resource
    include Enumerable

    class << self
      def retrieve(sixer, params = {})
        resource_collection = new(sixer)
        resource_collection.retrieve(params)
      end
    end

    def resource_class
      self.class.name.sub("Collection", "").singularize.constantize
    end

    def each(&block)
      Array(properties["response"]).map do |resource_properties|
        resource = resource_class.new(sixer, resource_properties)
        yield resource
      end
    end

    def each_in_all_pages(&block)
      each(&block)
      return if last_page?
      next_page.each_in_all_pages(&block)
    end

    def all
      AllResources.new(self)
    end

    def each_in_all_pages(&block)
      each(&block)
      return if last_page?
      next_page.each_in_all_pages(&block)
    end

    def page_number
      response["pagination"]["current"].to_i
    end

    def last_page?
      response["pagination"]["next"].nil?
    end

    def next_page
      new_params = params.merge({ "page" => (page_number + 1) })
      self.class.retrieve(sixer, new_params)
    end
  end
end
