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

# check that dogecoind is running and that our credentials are correct
if client.valid?
    # get a new wallet address
    new_wallet_addr = client.get_new_address

    # get the balance of our new wallet
    my_balance = client.get_balance(new_wallet_addr)
    puts "I have #{my_balance} doge!"
else
    puts 'Something is wrong...'
end
```

## Available Methods

<table>
<tr>
<th> Method </th>
<th> Params </th>
<th> Description </th>
<th>unlckd wallet req?
</th></tr>
<tr>
<td> add_multi_sig_address </td>
<td> [nrequired] ["key","key"] [account] </td>
<td> <b>Currently only available on testnet</b> Add a nrequired-to-sign multisignature address to the wallet. Each key is a dogecoin address or hex-encoded public key. If [account] is specified, assign address to [account]. </td>
<td> No
</td></tr>
<tr>
<td> backup_wallet </td>
<td> [destination] </td>
<td> Safely copies wallet.dat to destination, which can be a directory or a path with filename. </td>
<td> No
</td></tr>
<tr>
<td> dump_priv_key </td>
<td> [dogecoinaddress] </td>
<td> Reveals the private key corresponding to <dogecoinaddress< </td>
<td> Yes
</td></tr>
<tr>
<td> encrypt_wallet </td>
<td> [passphrase] </td>
<td> Encrypts the wallet with <passphrase<. </td>
<td> No
</td></tr>
<tr>
<td> get_account </td>
<td> [dogecoinaddress] </td>
<td> Returns the account associated with the given address. </td>
<td> No
</td></tr>
<tr>
<td> get_account_address </td>
<td> [account] </td>
<td> Returns the current dogecoin address for receiving payments to this account. </td>
<td> No
</td></tr>
<tr>
<td> get_addresses_by_account </td>
<td> [account] </td>
<td> Returns the list of addresses for the given account. </td>
<td> No
</td></tr>
<tr>
<td> get_balance </td>
<td> [account] [minconf=1] </td>
<td> If [account] is not specified, returns the server's total available balance.<br />If [account] is specified, returns the balance in the account. </td>
<td> No
</td></tr>
<tr>
<td> get_block </td>
<td> [hash] </td>
<td> Returns information about the given block hash. </td>
<td> No
</td></tr>
<tr>
<td> get_block_count </td>
<td> </td>
<td> Returns the number of blocks in the longest block chain. </td>
<td> No
</td></tr>
<tr>
<td> get_block_hash </td>
<td> [index] </td>
<td> Returns hash of block in best-block-chain at <index< </td>
<td> No
</td></tr>
<tr>
<td> get_block_number </td>
<td> </td>
<td> <b>Deprecated</b>. Use getblockcount. </td>
<td> No
</td></tr>
<tr>
<td> get_connection_count </td>
<td> </td>
<td> Returns the number of connections to other nodes. </td>
<td> No
</td></tr>
<tr>
<td> get_difficulty </td>
<td> </td>
<td> Returns the proof-of-work difficulty as a multiple of the minimum difficulty. </td>
<td> No
</td></tr>
<tr>
<td> get_generate </td>
<td> </td>
<td> Returns true or false whether dogecoind is currently generating hashes </td>
<td> No
</td></tr>
<tr>
<td> get_hashes_per_sec </td>
<td> </td>
<td> Returns a recent hashes per second performance measurement while generating. </td>
<td> No
</td></tr>
<tr>
<td> get_info </td>
<td> </td>
<td> Returns an object containing various state info. </td>
<td> No
</td></tr>
<tr>
<td> get_memory_pool </td>
<td> [data] </td>
<td> If [data] is not specified, returns data needed to construct a block to work on:
<ul><li> "version": block version
</li><li> "previousblockhash": hash of current highest block
</li><li> "transactions": contents of non-coinbase transactions that should be included in the next block
</li><li> "coinbasevalue": maximum allowable input to coinbase transaction, including the generation award and transaction fees
</li><li> "time": timestamp appropriate for next block
</li><li> "bits": compressed target of next block
</li></ul>
<p>If [data] is specified, tries to solve the block and returns true if it was successful.
</p>
</td>
<td> No
</td></tr>
<tr>
<td> get_mining_info </td>
<td> </td>
<td> Returns an object containing mining-related information:
<ul><li> blocks
</li><li> currentblocksize
</li><li> currentblocktx
</li><li> difficulty
</li><li> errors
</li><li> generate
</li><li> genproclimit
</li><li> hashespersec
</li><li> pooledtx
</li><li> testnet
</li></ul>
</td>
<td> No
</td></tr>
<tr>
<td> get_new_address </td>
<td> [account] </td>
<td> Returns a new dogecoin address for receiving payments.  If [account] is specified (recommended), it is added to the address book so payments received with the address will be credited to [account]. </td>
<td> No
</td></tr>
<tr>
<td> get_received_by_account </td>
<td> [account] [minconf=1] </td>
<td> Returns the total amount received by addresses with [account] in transactions with at least [minconf] confirmations. If [account] not provided return will include all transactions to all accounts. (version 0.3.24-beta) </td>
<td> No
</td></tr>
<tr>
<td> get_received_by_address </td>
<td> [dogecoinaddress] [minconf=1] </td>
<td> Returns the total amount received by <dogecoinaddress< in transactions with at least [minconf] confirmations. While some might consider this obvious, value reported by this only considers *receiving* transactions. It does not check payments that have been made *from* this address. In other words, this is not "getaddressbalance". Works only for addresses in the local wallet, external addresses will always show 0. </td>
<td> No
</td></tr>
<tr>
<td> get_transaction </td>
<td> [txid] </td>
<td> Returns an object about the given transaction containing:
<ul><li> "amount": total amount of the transaction
</li><li> "confirmations":  number of confirmations of the transaction
</li><li> "txid": the transaction ID
</li><li> "time": time the transaction occurred
</li><li> "details" - An array of objects containing:
<ul><li> "account"
</li><li> "address"
</li><li> "category"
</li><li> "amount"
</li></ul>
</li></ul>
</td>
<td> No
</td></tr>
<tr>
<td> get_work </td>
<td> [data] </td>
<td> If [data] is not specified, returns formatted hash data to work on:
<ul><li> "midstate": precomputed hash state after hashing the first half of the data
</li><li> "data": block data
</li><li> "hash1": formatted hash buffer for second hash
</li><li> "target": little endian hash target
</li></ul>
<p>If [data] is specified, tries to solve the block and returns true if it was successful.
</p>
</td>
<td> No
</td></tr>
<tr>
<td> help </td>
<td> [command] </td>
<td> List commands, or get help for a command. </td>
<td> No
</td></tr>
<tr>
<td> import_priv_key </td>
<td> [dogecoinprivkey] [label] </td>
<td> Adds a private key (as returned by dumpprivkey) to your wallet. </td>
<td> Yes
</td></tr>
<tr>
<td> key_pool_refill </td>
<td> </td>
<td> Fills the keypool, requires wallet passphrase to be set. </td>
<td> Yes
</td></tr>
<tr>
<td> list_accounts </td>
<td> [minconf=1] </td>
<td> Returns Object that has account names as keys, account balances as values. </td>
<td> No
</td></tr>
<tr>
<td> list_received_by_account </td>
<td> [minconf=1] [includeempty=false] </td>
<td> Returns an array of objects containing:
<ul><li> "account": the account of the receiving addresses
</li><li> "amount": total amount received by addresses with this account
</li><li> "confirmations": number of confirmations of the most recent transaction included
</li></ul>
</td>
<td> No
</td></tr>
<tr>
<td> list_received_by_address </td>
<td> [minconf=1] [includeempty=false] </td>
<td> Returns an array of objects containing:
<ul><li> "address": receiving address
</li><li> "account": the account of the receiving address
</li><li> "amount": total amount received by the address
</li><li> "confirmations": number of confirmations of the most recent transaction included
</li></ul>
<p>To get a list of accounts on the system, execute dogecoind listreceivedbyaddress 0 true
</p>
</td>
<td> No
</td></tr>
<tr>
<td> list_since_block</td>
<td> [blockhash] [target-confirmations] </td>
<td> Get all transactions in blocks since block [blockhash], or all transactions if omitted. </td>
<td> No
</td></tr>
<tr>
<td> list_transactions </td>
<td> [account] [count=10] [from=0] </td>
<td> Returns up to [count] most recent transactions skipping the first [from] transactions for account [account]. If [account] not provided will return recent transaction from all accounts.
</td>
<td> No
</td></tr>
<tr>
<td> move </td>
<td> [fromaccount] [toaccount] [amount] [minconf=1] [comment] </td>
<td> Move from one account in your wallet to another </td>
<td> No
</td></tr>
<tr>
<td> send_from </td>
<td> [fromaccount] [todogecoinaddress] [amount] [minconf=1] [comment] [comment-to] </td>
<td> <amount< is a real and is rounded to 8 decimal places. Will send the given amount to the given address, ensuring the account has a valid balance using [minconf] confirmations. Returns the transaction ID if successful (not in JSON object). </td>
<td> Yes
</td></tr>
<tr>
<td> send_many </td>
<td> [fromaccount] [address:amount,...] [minconf=1] [comment] </td>
<td> amounts are double-precision floating point numbers </td>
<td> Yes
</td></tr>
<tr>
<td> send_to_address </td>
<td> [dogecoinaddress] [amount] [comment] [comment-to] </td>
<td> <amount< is a real and is rounded to 8 decimal places. Returns the transaction ID <txid< if successful. </td>
<td> Yes
</td></tr>
<tr>
<td> set_account </td>
<td> [dogecoinaddress] [account] </td>
<td> Sets the account associated with the given address. Assigning address that is already assigned to the same account will create a new address associated with that account. </td>
<td> No
</td></tr>
<tr>
<td> set_generate </td>
<td> [generate] [genproclimit] </td>
<td> [generate] is true or false to turn generation on or off.

Generation is limited to [genproclimit] processors, -1 is unlimited. </td>
<td> No
</td></tr>
<tr>
<td> sign_message </td>
<td> [dogecoinaddress] [message] </td>
<td> Sign a message with the private key of an address. </td>
<td> Yes
</td></tr>
<tr>
<td> set_tx_fee </td>
<td> [amount] </td>
<td> [amount] is a real and is rounded to the nearest 0.00000001 </td>
<td> No
</td></tr>
<tr>
<td> stop </td>
<td> </td>
<td> Stop dogecoin server. </td>
<td> No
</td></tr>
<tr>
<td> validate_address </td>
<td> [dogecoinaddress] </td>
<td> Return information about [dogecoinaddress]. </td>
<td> No
</td></tr>
<tr>
<td> verify_message </td>
<td> [dogecoinaddress] [signature] [message] </td>
<td> Verify a signed message. </td>
<td> No
</td></tr>
<tr>
<td> wallet_lock </td>
<td>  </td>
<td> Removes the wallet encryption key from memory, locking the wallet. After calling this method,  you will need to call walletpassphrase again before being able to call any methods which require the wallet to be unlocked. </td>
<td> No
</td></tr>
<tr>
<td> wallet_passphrase </td>
<td> [passphrase] [timeout] </td>
<td> Stores the wallet decryption key in memory for <timeout< seconds. </td>
<td> No
</td></tr>
<tr>
<td> wallet_passphrase_change </td>
<td> [oldpassphrase] [newpassphrase] </td>
<td> Changes the wallet passphrase from <oldpassphrase< to <newpassphrase<. </td>
<td> No
</td></tr></table>

*Table stolen from [node-dogecoin](https://github.com/countable/node-dogecoin)

## Contributing

For local testing, make sure to replace the user/password in `spec/client_spec.rb` and `spec/dogecoin_client_spec.rb` with the credentials for your local dogecoind.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Can't I just use a client for bitcoin or litecoin?

Perhaps, but this way you don't need to worry about any current or future api inconsistencies. Plus, why use a tool built for an inferior alt coin?
