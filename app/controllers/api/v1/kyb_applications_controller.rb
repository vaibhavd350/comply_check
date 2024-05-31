# frozen_string_literal: true

module Api
  module V1
    class KybApplicationsController < Api::V1::ApiController
      before_action :load_kyb_application, only: %i[show approve reject]

      def index
        @kyb_applications = KybApplication.includes(company: %i[directors documents user])
                                          .order(created_at: :desc)
        authorize @kyb_applications
      end

      def show; end

      def approve
        if @kyb_application.update(status: 'approved', resubmitted: false)
          prepare_response(true, 'KYB Application approved successfully.', :ok)
        else
          prepare_response(false, @kyb_application.errors.full_messages.to_sentence, :unprocessable_entity)
        end
      end

      def reject
        if @kyb_application.update(status: 'rejected', rejection_reason: params[:rejection_reason], resubmitted: false)
          prepare_response(true, 'KYB Application rejected successfully.', :ok)
        else
          prepare_response(false, @kyb_application.errors.full_messages.to_sentence, :unprocessable_entity)
        end
      end

      private

      def load_kyb_application
        @kyb_application = KybApplication.includes(company: %i[directors documents user])
                                         .find_by_id(params[:id])

        return prepare_response(false, 'KYB Application not found.', :not_found) unless @kyb_application.present?

        # Check authorization when KYB application found
        authorize @kyb_application
      end
    end
  end
end
