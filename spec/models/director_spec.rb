require 'rails_helper'

RSpec.describe Director, type: :model do
  let(:company) { create(:company) }

  subject do
    described_class.new(
      name: 'John Doe',
      designation: 'CEO',
      contact_information: 'john.doe@example.com',
      company:
    )
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:designation) }
    it { should validate_presence_of(:contact_information) }
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a designation' do
    subject.designation = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without contact information' do
    subject.contact_information = nil
    expect(subject).to_not be_valid
  end
end
