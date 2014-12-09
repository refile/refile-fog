# Refile::Memory

An in-memory backend for [Refile](https://github.com/elabs/refile).

This probably isn't super useful, but it serves as an illustration on how to
write backends for Refile.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refile-memory'
```

Set up Refile to use the memory backend:

``` ruby
Refile.configure do |config|
  config.cache = Refile::Memory::Backend.new
  config.store = Refile::Memory::Backend.new
end
```

## License

[MIT](License.txt)
