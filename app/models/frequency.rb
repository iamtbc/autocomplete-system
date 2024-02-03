class Frequency < ApplicationRecord
  class << self
    def generate_trie(redis_gateway:, version:)
      RedisTrie.new(redis_gateway:).tap do |trie|
        self.where(version: version).each do |frequency|
          trie.insert(frequency.query, frequency.count)
        end
      end
    end
  end
end
