# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :companies, dependent: :destroy

  after_create :assign_default_role

  def assign_default_role
    add_role(:company_owner) if roles.blank?
  end

  def company_owner?
    has_role?(:company_owner)
  end

  def compliance_officer?
    has_role?(:compliance_officer)
  end
end
