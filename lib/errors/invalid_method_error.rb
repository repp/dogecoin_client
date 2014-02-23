class DogecoinClient
  class InvalidMethodError < StandardError

    attr_accessor :message

    def initialize(method_name)
      @message = "#{method_name} is not a valid method."
    end

  end
end