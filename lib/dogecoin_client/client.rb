require 'net/http'
require 'uri'
require 'json'
require 'dogecoin_client'
require 'dogecoin_client/methods'
require 'errors/http_error'
require 'errors/rpc_error'
require 'errors/invalid_method_error'


module DogecoinClient
  class Client

    attr_accessor :options

    def initialize(options = {})
      @options = get_defaults.merge(options)
    end

    def valid?
      post_body = { method: 'getinfo', id: Time.now.to_i }.to_json
      http_post_request(post_body).class == Net::HTTPOK rescue false
    end

    def method_missing(name, *args)
      raise DogecoinClient::InvalidMethodError.new(name) unless DogecoinClient::METHODS.include?(name.to_s)

      response = http_post_request( get_post_body(name, args) )
      get_response_data(response)
    end

    def http_post_request(post_body)
      req = Net::HTTP::Post.new(get_service_uri)
      req.basic_auth @options[:user], @options[:password]
      req.content_type = 'application/json'
      req.body = post_body

      response = Net::HTTP.start(@options[:host], @options[:port]) {|http| http.request(req) }

      return response if response.class == Net::HTTPOK or response.class == Net::HTTPInternalServerError
      raise DogecoinClient::HTTPError.new(response)
    end

    private

    def get_service_uri
      URI("#{@options[:protocol]}://#{@options[:host]}:#{@options[:port]}").request_uri
    end

    def get_post_body(name, args)
      { method: de_ruby_style(name), params: args, id: Time.now.to_i }.to_json
    end

    def get_response_data(http_ok_response)
      resp = JSON.parse( http_ok_response.body )
      raise DogecoinClient::RPCError.new(resp['error']['message']) if resp['error'] and http_ok_response.class == Net::HTTPInternalServerError
      resp['result']
    end

    def de_ruby_style(method_name)
       method_name.to_s.tr('_', '').downcase.to_sym
    end

    def get_defaults
      DogecoinClient.configuration.instance_variables.each.inject({}) {|hash, var|
        hash[var.to_s.delete('@').to_sym] = DogecoinClient.configuration.instance_variable_get(var);
        hash
      }
    end

  end
end