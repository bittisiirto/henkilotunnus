# Hetu

hetu is a gem for validating Finnish [personal identification numbers](http://en.wikipedia.org/wiki/National_identification_number#Finland).

```ruby
Hetu.valid?("280264-051U")

class User < ActiveRecord
	validates :pin, hetu: true
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'hetu'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hetu

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
