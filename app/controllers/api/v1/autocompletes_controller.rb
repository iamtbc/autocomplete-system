module Api
  module V1
    class AutocompletesController < ApplicationController
      before_action :set_cache_policy

      def show
        autocompletes = search_service.search(q: params[:q])

        render json: autocompletes
      end

      private

      def set_cache_policy
        expires_in 1.hour, public: false
      end

      def search_service
        @search_service ||= Autocompletes::Searcher.new(cache_service:, expires_in: 1.hour)
      end

      def cache_service
        @cache_service ||= Rails.cache
      end
    end
  end
end
