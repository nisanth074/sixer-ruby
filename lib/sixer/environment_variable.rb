class Sixer
  class EnvironmentVariable < Resource
    def key
      properties["key"]
    end

    def value
      properties["value"]
    end

    def readonly?
      !!properties["readonly"]
    end
  end
end
