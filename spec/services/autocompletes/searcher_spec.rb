require 'rails_helper'

FIXTURE_FILE_PATH = 'spec/fixtures/files/autocompletes.json'

RSpec.describe Autocompletes::Searcher do
  let(:host) { "localhost" }
  let(:port) { 6379 }
  let(:db) { 9 }
  let(:redis_gateway) { RedisGateway.new(host: host, port: port, db: db) }
  let(:cache_service) { Autocompletes::Cacher.new(cache_gateway: redis_gateway) }
  let(:service) { described_class.new(cache_service: cache_service) }

  before do
    cache_service.import_from_json_file(file_path: FIXTURE_FILE_PATH)
  end

  after do
    redis_gateway.flushdb
  end

  describe '#search' do
    context 'when the value of the search key exists in the cache store' do
      subject(:values) { service.search(q: 'bee') }

      it 'returns the cached results' do
        expect(values).to eq([
          [ 'bee', 20 ],
          [ 'beer', 10 ]
        ])
      end
    end
  end
end
