# spec/models/document_spec.rb
require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:document) { build(:document) }

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:document_type) }
    it { should validate_presence_of(:file) }

    it 'validates file size' do
      expect(document).to validate_size_of(:file).less_than(100.megabytes).with_message('size is exceeding the limit of 100MB')
    end

    it 'validates file content type' do
      expect(document).to validate_content_type_of(:file)
        .allowing('image/png', 'image/jpg', 'image/jpeg', 'application/pdf')
    end
  end
end
