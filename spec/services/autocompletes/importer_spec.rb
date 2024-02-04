require 'rails_helper'

RSpec.describe Autocompletes::Importer do
  describe '#import_with_redis_trie' do
    subject do
      described_class.new(trie_initializer:, trie_builder:).import(version:)
    end

    context 'when trie_factory is RedisTrieFactory' do
      include_context 'use redis_gateway'

      before do
        create(:frequency, query: 'apple', count: 10, version: version)
      end

      let(:trie_initializer) { RedisTrieFactory.new(redis_gateway: redis_gateway) }
      let(:trie_builder) { Frequency }
      let(:version) { '20240130003709' }

      it 'imports data from trie to the database' do
        expect { subject }
        .to change { Autocomplete.order(:query).pluck(:query, :candidates) }
        .from([])
        .to([
          [ 'a', [ [ 'apple', 10 ] ] ],
          [ 'ap', [ [ 'apple', 10 ] ] ],
          [ 'app', [ [ 'apple', 10 ] ] ],
          [ 'appl', [ [ 'apple', 10 ] ] ],
          [ 'apple', [ [ 'apple', 10 ] ] ]
        ])
      end
    end
  end
end
