require 'net/http'
require 'uri'
require 'json'
require 'errors/http_error'
require 'errors/rpc_error'

module DogecoinClient
  class Client

    attr_accessor :options

    DEFAULTS = {
        host:    'localhost',
        port:    22555,
        method:  :post,
        protocol: :http,
        user:    '',
        password:    '',
    }

    def initialize(options = {})
      @options = DEFAULTS.merge(options)
    end

    def valid?
      post_body = { method: 'getinfo', id: Time.now.to_i }.to_json
      http_post_request(post_body).class == Net::HTTPOK
    end

    def method_missing(name, *args)
      post_body = { method: de_ruby_style(name), params: args, id: Time.now.to_i }.to_json
      response = http_post_request(post_body)
      return get_response_data(response) if response.class == Net::HTTPOK or response.class == Net::HTTPInternalServerError
      raise DogecoinClient::HTTPError.new(response)
    end

    def http_post_request(post_body)
      req = Net::HTTP::Post.new(get_service_uri)
      req.basic_auth @options[:user], @options[:password]
      req.content_type = 'application/json'
      req.body = post_body

      Net::HTTP.start(@options[:host], @options[:port]) {|http|
        http.request(req)
      }
    end

    private

    def get_service_uri
      URI("#{@options[:protocol]}://#{@options[:host]}:#{@options[:port]}").request_uri
    end

    def get_response_data(http_ok_response)
      resp = JSON.parse( http_ok_response.body )
      raise DogecoinClient::RPCError.new(resp['error']['message']) if resp['error']
      resp['result']
    end

    def de_ruby_style(method_name)
       method_name.to_s.tr('_', '').downcase.to_sym
    end

  end
end