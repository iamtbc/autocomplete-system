module Autocompletes
  class Searcher
    def initialize(cache_service:, expires_in:)
      @cache_service = cache_service
      @expires_in = expires_in
    end

    def search(q:)
      @cache_service.fetch(cache_key_for(q), expires_in: @expires_in) do
        Autocomplete.find_by(query: q)&.candidates || []
      end
    end

    private

    def cache_key_for(q)
      "Autocompletes::Searcher#search:#{q}"
    end
  end
end
