require "refile/memory"
require "refile/spec_helper"

RSpec.describe Refile::Memory::Backend do
  let(:backend) { Refile::Memory::Backend.new(max_size: 100) }

  it_behaves_like :backend
end

