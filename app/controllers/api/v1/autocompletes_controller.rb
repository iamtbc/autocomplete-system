module Api
  module V1
    class AutocompletesController < ApplicationController
      def show
        autocompletes = search_service.search(q: params[:q])

        render json: autocompletes
      end

      private

      def search_service
        @search_service ||= Autocompletes::Searcher.new(cache_service:)
      end

      def cache_service
        @cache_service ||= Autocompletes::Cacher.new(cache_gateway:)
      end

      def cache_gateway
        host = ENV.fetch("AUTOCOMPLETE_SYSTEM_CACHE_HOST")
        port = ENV.fetch("AUTOCOMPLETE_SYSTEM_CACHE_PORT")
        db = ENV.fetch("AUTOCOMPLETE_SYSTEM_CACHE_DB")
        @cache_gateway ||= RedisGateway.new(host:, port:, db:)
      end
    end
  end
end
