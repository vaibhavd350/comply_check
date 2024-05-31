# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:user) { create(:user) }
  let(:company) do
    Company.new(
      user:,
      legal_name: 'Valid Company',
      email: 'contact@company.com',
      address: '123 Street',
      phone_number: '1234567890',
      primary_contact_name: 'John Doe',
      primary_contact_phone_number: '0987654321'
    )
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:directors).dependent(:destroy) }
    it { should have_many(:documents).dependent(:destroy) }
    it { should have_one(:kyb_application).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:legal_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:primary_contact_name) }
    it { should validate_presence_of(:primary_contact_phone_number) }
    it { should validate_uniqueness_of(:legal_name).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should allow_value('contact@company.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should allow_value('1234567890').for(:phone_number) }
    it { should allow_value('123-456-7890').for(:phone_number) }
    it { should allow_value('+919876543210').for(:phone_number) }
    it { should_not allow_value('invalid_phone_number').for(:phone_number) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:directors) }
    it { should accept_nested_attributes_for(:documents) }
    it { should accept_nested_attributes_for(:kyb_application) }
  end

  describe 'callbacks' do
    it 'creates a KYB application after creating a company' do
      expect { company.save }.to change { KybApplication.count }.by(1)
    end
  end

  describe '#add_kyb_application' do
    it 'builds and saves a KYB application for the company' do
      company.save
      expect(company.kyb_application).to be_present
    end
  end
end
