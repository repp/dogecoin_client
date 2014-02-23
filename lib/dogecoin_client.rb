require 'dogecoin_client/version'
require 'dogecoin_client/client'

module DogecoinClient
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

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

end
