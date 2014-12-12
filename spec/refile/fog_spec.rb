require "pry"
require "refile/fog"
require "refile/spec_helper"

Fog.mock!

RSpec.configure do |config|
  config.before do
    @connection = ::Fog::Storage.new(provider: "AWS", aws_access_key_id: "zyx", aws_secret_access_key: "abc421")
    @connection.directories.create(key: "refile-fog-test")
  end

  config.after do
    @connection.directories.get("refile-fog-test").files.each(&:destroy)
    @connection.directories.get("refile-fog-test").destroy
  end
end

RSpec.describe Refile::Fog::Backend do
  let(:backend) { Refile::Fog::Backend.new(max_size: 100, prefix: "cache", connection: @connection, directory: "refile-fog-test") }

  it_behaves_like :backend
end

