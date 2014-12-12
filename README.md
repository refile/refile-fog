# Refile::Fog

NOTE: Work in Progress!

An backend for [Refile](https://github.com/elabs/refile) which provides storage
in multiple cloud storage services via the [Fog](https://github.com/fog/fog)
cloud services gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refile-fog'
```

Set up Refile to use the fog backend:

``` ruby
Refile.configure do |config|
  config.cache = Refile::Fog::Backend.new
  config.store = Refile::Fog::Backend.new
end
```

## License

[MIT](License.txt)
