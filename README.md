# Refile::Fog

[![Build Status](https://travis-ci.org/refile/refile-fog.svg)](https://travis-ci.org/refile/refile-fog)

A backend for [Refile](https://github.com/elabs/refile) which provides storage
in multiple cloud storage services via the [Fog](https://github.com/fog/fog)
cloud services gem.

If you're looking for a backend for Amazon S3, please use Refile's build in S3
backend. It is far superior to using S3 via Fog.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refile-fog'
```

You also need to add the storage provider you use.

Example for google storage:

```ruby
gem 'fog-google'
gem 'google-api-client', '~> 0.8.6'

```

Set up Refile to use the fog backend:

``` ruby
# config/initializers/refile.rb

require "fog/google"
require "refile/fog"

credentials = {
  provider: "Google",
  aws_access_key_id: "zyx",
  aws_secret_access_key: "12345",
  directory: "my-app"
}

Refile.configure do |config|
  config.cache = Refile::Fog::Backend.new(prefix: "cache", **credentials)
  config.store = Refile::Fog::Backend.new(prefix: "store", **credentials)
end
```

## License

[MIT](License.txt)
