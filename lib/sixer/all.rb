class Sixer
  class All
    include Enumerable

    attr_reader :first_page

    def initialize(first_page)
      @first_page = first_page
    end

    def each
      page = first_page
      page.each { |resource| yield resource }
      return if page.last_page?

      new(page.next_page).each { |resource| yield resource }
    end
  end
end
