class DogecoinClient
  class HTTPError < StandardError

    attr_accessor :object, :message

    def initialize(object)
      @object = object
      @message = "Expected NET::HTTPOK but got: #{object.class}"
    end

  end
end