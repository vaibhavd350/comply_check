# frozen_string_literal: true

FactoryBot.define do
  factory :director do
    name { 'Example Director' }
    designation { 'CEO' }
    email { 'director@example.com' }
    company_id { create(:company).id }
  end
end
