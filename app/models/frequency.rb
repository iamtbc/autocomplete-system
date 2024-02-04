class Frequency < ApplicationRecord
  class << self
    def generate_trie(trie_factory:, version:)
      trie = trie_factory.create

      self.where(version: version).each do |frequency|
        trie.insert(frequency.query, frequency.count)
      end

      trie
    end
  end
end
