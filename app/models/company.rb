# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :user

  has_many :directors, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_one :kyb_application, dependent: :destroy

  validates :legal_name, :email, uniqueness: { case_sensitive: false }
  validates :legal_name, :address, :phone_number, :primary_contact_name, :primary_contact_phone_number, presence: true
  validates :email, presence: true, format: {
    with: Devise.email_regexp,
    message: 'is not valid.'
  }
  validates :phone_number, presence: true, format: {
    with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/,
    message: 'is not valid.'
  }

  accepts_nested_attributes_for :directors, :documents, :kyb_application

  after_create :add_kyb_application

  def add_kyb_application
    build_kyb_application.save
  end
end
