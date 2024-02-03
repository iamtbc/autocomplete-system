require "rails_helper"

RSpec.describe Api::V1::AutocompletesController do
  describe '#show' do
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
      before do
        create(:autocomplete, query: 'b', candidates: [
          [ 'best', 35 ],
          [ 'bee', 20 ],
          [ 'be', 15 ],
          [ 'beer', 10 ]
        ])
      end

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
