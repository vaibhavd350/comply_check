# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Example User' }
    email { 'user@example.com' }
    password { 'password' }
    password_confirmation { 'password' }

    %i[company_owner compliance_officer].each do |role|
      trait role do
        after(:create) { |user| user.add_role(role) }
      end
    end
  end
end
