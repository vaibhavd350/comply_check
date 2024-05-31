# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    document_type { 'Type' }
    file do
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'example.pdf'), 'application/pdf')
    end
    company
  end
end
