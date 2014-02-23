require 'dogecoin_client/version'
require 'dogecoin_client/client'

class DogecoinClient

  def initialize(options = {})
    @client = DogecoinClient::Client.new(options)
  end

  # Delegate everything to the 'real' Client
  def method_missing(name, *args)
    @client.send(name, *args)
  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :host, :port, :protocol, :user, :password

    def initialize
      self.host = 'localhost'
      self.port = 22555
      self.protocol = :http
      self.user = ''
      self.password = ''
    end

  end

end
