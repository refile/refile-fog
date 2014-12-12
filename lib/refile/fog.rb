require "fog"
require "refile"
require "refile/fog/version"

module Refile
  module Fog
    class Backend
      attr_reader :directory

      def initialize(max_size: nil, prefix: nil, hasher: Refile::RandomHasher.new, **options)
        @connection = ::Fog::Storage.new(options)
        @hasher = hasher
        @max_size = max_size

        @directory = if prefix
          @connection.directories.get(prefix) or @connection.directories.create(key: prefix)
        else
          @connection
        end
      end

      def upload(uploadable)
        Refile.verify_uploadable(uploadable, @max_size)

        id = @hasher.hash(uploadable)

        @directory.files.create(key: id, body: uploadable)

        Refile::File.new(self, id)
      end

      def get(id)
        Refile::File.new(self, id)
      end

      def delete(id)
        file = head(id)
        file.destroy if file
      end

      def open(id)
        StringIO.new(read(id))
      end

      def read(id)
        file = @directory.files.get(id)
        file.body if file
      end

      def size(id)
        file = head(id)
        file.content_length if file
      end

      def exists?(id)
        !!head(id)
      end

      def head(id)
        @directory.files.head(id)
      end

      def clear!(confirm = nil)
        raise ArgumentError, "are you sure? this will remove all files in the backend, call as `clear!(:confirm)` if you're sure you want to do this" unless confirm == :confirm
        @directory.files.each(&:destroy)
      end
    end
  end
end
