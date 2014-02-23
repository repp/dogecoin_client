module DogecoinClient
  class RPCError < StandardError

    attr_accessor :message

    def initialize(message)
      @message = message
    end

  end
end