module Autocompletes
  class Searcher
    def initialize(cache_service:)
      @cache_service = cache_service
    end

    def search(q:)
      @cache_service.get(q:).to_a.sort_by { |_, v| -v }
    end
  end
end
