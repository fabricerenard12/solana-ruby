
# Solana-Ruby

Solana-Ruby is a Ruby SDK for interacting with the Solana blockchain. It allows you to easily make requests to the Solana network from your Ruby applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'solana-ruby', '~> 0.1.1'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install solana-ruby
```

## Usage

### Initialize the Client

```ruby
require 'solana-ruby'

client = SolanaRB::Client.new
```

### Subscribe to Account Changes

```ruby
client.account_subscribe('public_key') do |result|
  puts result
end
```

## Documentation

You can find the full documentation [here](https://fabricerenard12.github.io/solana-ruby).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fabricerenard12/solana-ruby.

## License

The gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).