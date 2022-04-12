# BungieSdk

The Unofficial, Incomplete, Hardly-Tested Bungie SDK for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bungie_sdk'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bungie_sdk

## Usage

```ruby
require 'bungie_sdk'

client     = BungieSdk::Client.new(token_filepath: './token.json')
membership = client.destiny_memberships.first
profile    = membership.profile
character  = profile.characters.first
vendor     = character.vendors.first
items      = vendor.items
items.each do |item|
  puts item.name
  puts item.type
  puts item.sockets
end
```

## Development

After forking the repo and cloning your fork, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tkmcclellan/bungie\_sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/bungie_sdk/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BungieSdk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bungie_sdk/blob/master/CODE_OF_CONDUCT.md).
