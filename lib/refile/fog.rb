require "refile"
require "refile/fog/version"

module Refile
  module Fog
    class Backend
      attr_reader :directory

      def initialize(max_size: nil, hasher: Refile::RandomHasher.new)
        @hasher = hasher
        @max_size = max_size
        @store = {}
      end

      def upload(uploadable)
        Refile.verify_uploadable(uploadable, @max_size)

        id = @hasher.hash(uploadable)

        @store[id] = uploadable.read

        Refile::File.new(self, id)
      end

      def get(id)
        Refile::File.new(self, id)
      end

      def delete(id)
        @store.delete(id)
      end

      def open(id)
        StringIO.new(@store[id])
      end

      def read(id)
        @store[id]
      end

      def size(id)
        @store[id].bytesize if exists?(id)
      end

      def exists?(id)
        @store.has_key?(id)
      end

      def clear!(confirm = nil)
        raise ArgumentError, "are you sure? this will remove all files in the backend, call as `clear!(:confirm)` if you're sure you want to do this" unless confirm == :confirm
        @store = {}
      end
    end
  end
end
