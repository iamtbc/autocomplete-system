module Autocompletes
  class Cacher
    PREFIX = "autocompletes"

    def initialize(cache_gateway:)
      @cache_gateway = cache_gateway
    end

    def import_from_json_file(file_path:)
      File.open(file_path, "r") do |file|
        data = JSON.load(file)
        data.each do |key, value|
          @cache_gateway.set(cache_key_for(q: key), value.to_json)
        end
      end
    end

    def get(q:)
      result = @cache_gateway.get(cache_key_for(q:))

      result.present? ? JSON.parse(result) : {}
    end

    private

    def cache_key_for(q:)
      "#{PREFIX}:#{q&.strip}"
    end
  end
end
