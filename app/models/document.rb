# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :company
  has_one_attached :file

  validates :document_type, :file, presence: true
  validates :file, attached: true, size: { less_than: 100.megabytes, message: 'size is exceeding the limit of 100MB' }
  validates :file, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf']
end
