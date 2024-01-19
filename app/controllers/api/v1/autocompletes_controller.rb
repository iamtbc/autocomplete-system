module Api
  module V1
    class AutocompletesController < ApplicationController
      def show
        render json: autocomplete_results_for(q: params[:q])
      end

      private

      def autocomplete_results_for(q:)
        if q == 'b'
          [
            ['best', 35],
            ['bee', 20],
            ['be', 15],
            ['beer', 10],
          ]
        else
          []
        end
      end
    end
  end
end
