require 'rails_helper'

RSpec.describe Autocompletes::Searcher do
  let(:cache_service) { Rails.cache }
  let(:service) { described_class.new(cache_service:, expires_in: 1.hour) }

  describe '#search' do
    after do
      cache_service.clear
    end

    context 'when cache is empty' do
      before do
        allow(Rails.cache).to receive(:fetch).and_yield
      end

      it 'fetches candidates from Autocomplete model' do
        expect(Autocomplete).to receive(:find_by).and_return(nil)

        service.search(q: 'test')
      end
    end

    context 'when cache is not empty' do
      before do
        allow(Rails.cache).to receive(:fetch).and_return([ [ 'test', 10 ] ])
      end

      it 'fetches candidates from cache' do
        expect(Autocomplete).not_to receive(:find_by)

        service.search(q: 'test')
      end
    end
  end
end
