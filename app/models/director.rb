# frozen_string_literal: true

class Director < ApplicationRecord
  belongs_to :company
  validates :name, :designation, :contact_information, presence: true
end
