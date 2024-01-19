require "rails_helper"

RSpec.describe Api::V1::AutocompletesController do
  describe '#show' do
    it 'returns a successful response' do
      get api_v1_autocomplete_path
      expect(response).to have_http_status(:ok)
    end

    it 'returns an empty JSON array' do
      get api_v1_autocomplete_path
      expect(response.parsed_body).to eq([])
    end
  end
end
