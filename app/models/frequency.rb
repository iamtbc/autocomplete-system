class Frequency < ApplicationRecord
  class << self
    def generate_trie(version:)
      Autocompletes::Trie.new.tap do |trie|
        self.where(version: version).each do |frequency|
          trie.insert(frequency.query, frequency.count)
        end
      end
    end
  end
end
