require 'rails_helper'

FIXTURE_FILE_PATH = 'spec/fixtures/files/autocompletes.json'

RSpec.describe Autocompletes::Trie do
  describe '#insert' do
    it 'inserts a word into the trie' do
      trie = Autocompletes::Trie.new

      expect { trie.insert('apple', 1) }.not_to raise_error
    end
  end

  describe '#search' do
    it 'returns true if the word is present in the trie' do
      trie = Autocompletes::Trie.new
      trie.insert('apple', 1)
      expect(trie.search('apple')).to be_an_instance_of Autocompletes::Trie::Node
    end

    it 'returns false if the word is not present in the trie' do
      trie = Autocompletes::Trie.new
      expect(trie.search('apple')).to be nil
    end
  end

  describe '#to_hash_table' do
    it 'returns a hash table of the trie' do
      trie = Autocompletes::Trie.new
      trie.insert('be', 15)
      trie.insert('bee', 20)
      trie.insert('beer', 10)
      trie.insert('best', 35)

      File.open(FIXTURE_FILE_PATH, "r") do |file|
        expect(trie.to_hash_table).to eq JSON.load(file)
      end
    end
  end
end
