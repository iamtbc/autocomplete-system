require 'rails_helper'

RSpec.describe RedisTrie, type: :model do
  shared_context 'use redis_gateway' do
    let(:host) { ENV["AUTOCOMPLETE_SYSTEM_CACHE_HOST"] }
    let(:port) { ENV["AUTOCOMPLETE_SYSTEM_CACHE_PORT"] }
    let(:db) { 9 }
    let(:redis_gateway) { RedisGateway.new(host: host, port: port, db: db) }

    after do
      redis_gateway.flushdb
    end
  end

  describe '#insert' do
    include_context 'use redis_gateway'

    it 'inserts the word with count into the trie' do
      trie = RedisTrie.new(redis_gateway:)
      expect { trie.insert('test', 10) }.not_to raise_error
    end
  end

  describe '#search' do
    include_context 'use redis_gateway'

    it 'returns the top 5 items with the highest frequency of words matching the query' do
      trie = RedisTrie.new(redis_gateway:)
      trie.insert('be', 15)
      trie.insert('bee', 20)
      trie.insert('beer', 10)
      trie.insert('best', 35)
      trie.insert('before', 25)
      trie.insert('behind', 5)

      expect(trie.search('be')).to eq([
        [ 'best', 35.0 ],
        [ 'before', 25.0 ],
        [ 'bee', 20.0 ],
        [ 'be', 15.0 ],
        [ 'beer', 10 ]
      ])
    end
  end

  describe '#find_in_batches' do
    include_context 'use redis_gateway'

    it 'yields keys and values in batches' do
      trie = RedisTrie.new(redis_gateway:)
      trie.insert('be', 15)
      trie.insert('beer', 10)
      trie.insert('best', 35)

      sets = []
      trie.find_in_batches { sets.concat(_1) }

      expect(sets.sort_by { |set| set.first }).to eq [
        [ "b", [ [ "best", 35 ], [ "be", 15 ], [ "beer", 10 ] ] ],
        [ "be", [ [ "best", 35 ], [ "be", 15 ], [ "beer", 10 ] ] ],
        [ "bee", [ [ "beer", 10 ] ] ],
        [ "beer", [ [ "beer", 10 ] ] ],
        [ "bes", [ [ "best", 35 ] ] ],
        [ "best", [ [ "best", 35 ] ] ]
      ]
    end
  end
end
