# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < Api::V1::ApiController
      before_action :load_company, only: %i[show update destroy resubmit_kyb_application]
      before_action :load_kyb_application, only: %i[resubmit_kyb_application]

      def index
        @companies = current_user.companies
                                 .includes(:directors, :documents, :kyb_application, :user)
        authorize @companies
      end

      def create
        @company = current_user.companies.new(company_params)
        authorize @company
        if @company.save
          @company
        else
          prepare_response(false, @company.errors.full_messages.to_sentence, :unprocessable_entity)
        end
      end

      def show; end

      def update
        if @company.update(company_params)
          @company
        else
          prepare_response(false, @company.errors.full_messages.to_sentence, :unprocessable_entity)
        end
      end

      def destroy
        if @company.destroy
          prepare_response(true, 'Company records deleted successfully.', :ok)
        else
          prepare_response(false, @company.errors.full_messages.to_sentence, :unprocessable_entity)
        end
      end

      def resubmit_kyb_application
        if @kyb_application.update(status: 'pending', resubmitted: true, rejection_reason: nil)
          @kyb_application.company
        else
          prepare_response(false, @kyb_application.errors.full_messages.to_sentence, :unprocessable_entity)
        end
      end

      private

      def load_company
        @company = current_user.companies
                               .includes(:directors, :documents, :kyb_application, :user)
                               .find_by_id(params[:id])

        return prepare_response(false, 'Company not found.', :not_found) unless @company.present?

        # Check authorization when company found
        authorize @company
      end

      def load_kyb_application
        @kyb_application = @company.kyb_application

        return prepare_response(false, 'KYB Application not found.', :not_found) unless @kyb_application.present?

        # Check authorization when KYB application found
        authorize @kyb_application
      end

      def company_params
        params.require(:company).permit(
          :legal_name, :address, :email, :phone_number, :primary_contact_name, :primary_contact_phone_number,
          directors_attributes: %i[id name designation contact_information],
          documents_attributes: %i[id name document_type file]
        )
      end
    end
  end
end
