class Cloud66
  class AllResources
    include Enumerable

    attr_reader :first_page

    def initialize(first_page)
      @first_page = first_page
    end

    def each
      first_page.retrieve
      first_page.each_in_all_pages { |resource| yield resource }
    end
  end
end
