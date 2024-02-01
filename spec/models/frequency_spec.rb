require 'rails_helper'

RSpec.describe Frequency, type: :model do
  describe ".generate_trie" do
    let(:version) { "20240130003709" }
    before do
      create(:frequency, query: "apple", count: 10, version:)
      create(:frequency, query: "banana", count: 5, version:)
      create(:frequency, query: "cherry", count: 3, version: "20240130003710")
    end

    it "generates a trie with frequencies for the given version" do
      trie = Frequency.generate_trie(version:)

      expect(trie).to be_a(Autocompletes::Trie)
      expect(trie.search("apple")).to eq(10)
      expect(trie.search("banana")).to eq(5)
      expect(trie.search("cherry")).to be_nil
    end
  end
end
