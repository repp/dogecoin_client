require 'dogecoin_client/client'

describe DogecoinClient do

  def valid_client
    # make sure to replace these with the credentials from your own dogecoind
    DogecoinClient.new(user: 'dogecoinrpc', password: '5d36c07c20a43a281f54c07d72ce78cc')
  end

  it 'sets up and works with a valid client' do
    bad_client = DogecoinClient.new
    bad_client.valid?.should eql(false)

    valid_client.valid?.should eql(true)
  end

  it 'calls client methods correctly' do
    addr = valid_client.get_new_address
    addr[0].should eql('D')
  end

  it 'configures itself properly' do
    DogecoinClient.configure do |config|
      config.user = 'dogecoinrpc'
      config.password = '5d36c07c20a43a281f54c07d72ce78cc'
    end
    client = DogecoinClient.new
    client.valid?.should eql(true)
  end

end