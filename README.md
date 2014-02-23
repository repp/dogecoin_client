# DogecoinClient

DogecoinClient is a gem that makes it easy to work with dogecoin in ruby.

## Dependencies

The only requirement is a running dogecoin daemon ([dogecoind](https://github.com/dogecoin/dogecoin)). Make sure to check out the [doc section](https://github.com/dogecoin/dogecoin/tree/master-1.5/doc) and follow the instructions for your os.
NOTICE: by default dogecoind will only allow local connections.

## Installation

Add this line to your application's Gemfile:

    gem 'dogecoin_client'

Or install it yourself as:

    $ gem install dogecoin_client

## Configuration

If you're using rails you can create an initializer. Here are the default settings:

```ruby
# config/initializers/dogecoin_client.rb
DogecoinClient.configure do |config|
    config.host = 'localhost'
    config.port = 22555
    config.protocol = :http
    config.user = ''
    config.password = ''
end
```

You can also pass config variables as an options hash when creating a new client:

```ruby
client = DogecoinClient.new(user: 'my_dogecoind_username', password: 'my_super_secure_password')
```

## Example Usage

```ruby
# create a new instance of the client
client = DogecoinClient.new

# get a new wallet address
new_wallet_addr = client.get_new_address

# get the balance of our new wallet
client.get_balance(new_wallet_addr) # returns '0.00'
```

## Available Methods



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Can't I just use a client for bitcoin or litecoin?

Perhaps, but this way you don't need to worry about any current or future api inconsistencies. Plus, why use a tool built for an inferior alt coin?
