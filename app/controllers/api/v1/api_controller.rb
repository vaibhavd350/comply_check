# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      before_action :set_paper_trail_whodunnit
      before_action :authenticate_api_v1_user!

      include Pundit::Authorization
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      def current_user
        @current_user ||= current_api_v1_user
      end

      def user_not_authorized(_exception)
        prepare_response(false, 'Oops! You are not an authorized person to perform this action.', :unprocessable_entity)
      end

      private

      def prepare_response(response_type, response_message, rsponse_status)
        render json: {
          success: response_type,
          message: response_message
        }, status: rsponse_status
      end
    end
  end
end
