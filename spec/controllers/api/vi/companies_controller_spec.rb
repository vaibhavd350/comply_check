require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do
  let(:user) { create(:user, :company_owner) }
  let(:company) { create(:company, user:) }
  let(:valid_attributes) do
    {
      legal_name: 'Test Company',
      address: '123 Test St',
      email: 'test@example.com',
      phone_number: '1234567890',
      primary_contact_name: 'John Doe',
      primary_contact_phone_number: '0987654321'
    }
  end
  let(:invalid_attributes) { { legal_name: nil } }

  before do
    @user = user
    @token = @user.create_new_auth_token
    request.headers.merge!(@token)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Company' do
        expect do
          post :create, params: { company: valid_attributes }, format: :json
        end.to change(Company, :count).by(1)
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new company' do
        post :create, params: { company: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Legal name can't be blank")
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: company.to_param }, format: :json
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { legal_name: 'Updated Company Name' } }

      it 'updates the requested company' do
        put :update, params: { id: company.to_param, company: new_attributes }, format: :json
        company.reload
        expect(company.legal_name).to eq('Updated Company Name')
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the company' do
        put :update, params: { id: company.to_param, company: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Legal name can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested company' do
      company # create the company
      expect do
        delete :destroy, params: { id: company.to_param }, format: :json
      end.to change(Company, :count).by(-1)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #resubmit_kyb_application' do
    it 'resubmits the KYB application' do
      company # create the company and associated KYB application
      put :resubmit_kyb_application, params: { id: company.to_param }, format: :json
      company.reload
      expect(company.kyb_application.status).to eq('pending')
      expect(company.kyb_application.resubmitted).to be true
      expect(company.kyb_application.rejection_reason).to eq(nil)
      expect(response).to be_successful
    end
  end
end
