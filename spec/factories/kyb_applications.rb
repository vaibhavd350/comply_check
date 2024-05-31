# frozen_string_literal: true

FactoryBot.define do
  factory :kyb_application do
    status { 'pending' }
    rejection_reason { nil }
    company_id { create(:company).id }
  end
end
