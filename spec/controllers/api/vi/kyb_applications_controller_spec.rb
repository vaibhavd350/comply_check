require 'rails_helper'

RSpec.describe Api::V1::KybApplicationsController, type: :controller do
  let(:user) { create(:user, :compliance_officer) }
  let(:company) { create(:company, user:) }
  let(:kyb_application) { create(:kyb_application, company:) }

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

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: kyb_application.to_param }, format: :json
      expect(response).to be_successful
    end
  end

  describe 'PATCH #approve' do
    it 'approves the requested KYB application' do
      put :approve, params: { id: kyb_application.to_param }, format: :json
      kyb_application.reload
      expect(kyb_application.approved?).to be true
      expect(response).to be_successful
    end
  end

  describe 'PATCH #reject' do
    it 'rejects the requested KYB application' do
      rejection_reason = 'Some reason for rejection'
      put :reject, params: { id: kyb_application.to_param, rejection_reason: }, format: :json
      kyb_application.reload
      expect(kyb_application.rejected?).to be true
      expect(kyb_application.rejection_reason).to eq(rejection_reason)
      expect(response).to be_successful
    end
  end
end
