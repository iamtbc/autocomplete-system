module Autocompletes
  class Importer
    def initialize(trie_initializer:, trie_builder:)
      @trie_initializer = trie_initializer
      @trie_builder = trie_builder
    end

    def import(version:)
      trie = generate_trie(trie_factory: @trie_initializer, version:)
      import_from_trie_to_db(trie)
    end

    private

    delegate :generate_trie, to: :@trie_builder

    def import_from_trie_to_db(trie)
      trie.find_in_batches do |sets|
        attrs = sets.map { |query, candidates| { query:, candidates: } }
        Autocomplete.upsert_all(attrs, unique_by: :query)
      end
    end
  end
end
