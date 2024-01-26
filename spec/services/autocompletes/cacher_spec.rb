require 'rails_helper'

FIXTURE_FILE_PATH = 'spec/fixtures/files/autocompletes.json'

RSpec.describe Autocompletes::Cacher do
  let(:host) { "localhost" }
  let(:port) { 6379 }
  let(:db) { 9 }
  let(:redis_gateway) { RedisGateway.new(host: host, port: port, db: db) }
  let(:instance) { described_class.new(cache_gateway: redis_gateway) }

  describe '#import_from_json_file' do
    it 'imports data from JSON file to cache gateway' do
      instance.import_from_json_file(file_path: FIXTURE_FILE_PATH)

      expect(redis_gateway.get('autocompletes:best')).to eq({ "best": 35 }.to_json)
    end
  end

  describe '#get' do
    context 'when the value of the search key exists' do
      before do
        instance.import_from_json_file(file_path: FIXTURE_FILE_PATH)
      end

      after do
      end

      it 'retrieves deserialized value from cache gateway' do
        expect(instance.get(q: 'best')).to eq({ "best" => 35 })
      end
    end

    context 'when the value of the search key does not exist' do
      it 'returns empty hash' do
        expect(instance.get(q: 'unknown')).to eq({})
      end
    end

    context 'when the value of the search key is nil' do
      it 'returns empty hash' do
        expect(instance.get(q: nil)).to eq({})
      end
    end
  end
end
