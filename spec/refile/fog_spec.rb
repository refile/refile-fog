require "refile/fog"
require "refile/spec_helper"

RSpec.describe Refile::Fog::Backend do
  let(:backend) { Refile::Fog::Backend.new(max_size: 100) }

  it_behaves_like :backend
end

