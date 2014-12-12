require "pry"
require "refile/fog"
require "refile/spec_helper"

Fog.mock!

RSpec.describe Refile::Fog::Backend do
  let(:backend) { Refile::Fog::Backend.new(max_size: 100, prefix: "cache", provider: "AWS", aws_access_key_id: "zyx", aws_secret_access_key: "abc421") }

  it_behaves_like :backend
end

