require "rails_helper"

FIXTURE_FILE_PATH = 'spec/fixtures/files/autocompletes.json'

RSpec.describe Api::V1::AutocompletesController do
  describe '#show' do
    let(:host) { "localhost" }
    let(:port) { 6379 }
    let(:db) { 9 }
    let(:redis_gateway) { RedisGateway.new(host: host, port: port, db: db) }
    let(:cache_service) { Autocompletes::Cacher.new(cache_gateway: redis_gateway) }

    before do
      cache_service.import_from_json_file(file_path: FIXTURE_FILE_PATH)
    end

    after do
      redis_gateway.flushdb
    end

    before do
      allow(ENV).to receive(:fetch).with("AUTOCOMPLETE_SYSTEM_CACHE_HOST").and_return(host)
      allow(ENV).to receive(:fetch).with("AUTOCOMPLETE_SYSTEM_CACHE_PORT").and_return(port)
      allow(ENV).to receive(:fetch).with("AUTOCOMPLETE_SYSTEM_CACHE_DB").and_return(db)
    end

    shared_examples 'a successful response' do
      it 'returns a successful response' do
        get api_v1_autocomplete_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when q=' do
      it_behaves_like 'a successful response'

      it 'returns an empty JSON array' do
        get api_v1_autocomplete_path, params: { q: '' }
        expect(response.parsed_body).to eq([])
      end
    end

    context 'when q=b' do
      it_behaves_like 'a successful response'

      it 'returns an array of 4 results' do
        get api_v1_autocomplete_path, params: { q: 'b' }
        expect(response.parsed_body).to eq ([
          [ 'best', 35 ],
          [ 'bee', 20 ],
          [ 'be', 15 ],
          [ 'beer', 10 ]
        ])
      end
    end
  end
end
