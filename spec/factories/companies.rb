# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    legal_name { 'Example Company' }
    address { 'India' }
    email { 'company@example.com' }
    phone_number { '9876543210' }
    primary_contact_name { 'John' }
    primary_contact_phone_number { '9876543210' }
    user_id { create(:user).id }
  end
end
