# frozen_string_literal: true

class KybApplication < ApplicationRecord
  has_paper_trail

  belongs_to :company
  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected' }

  validate :verify_rejection_reason
  after_update :trigger_mail

  def verify_rejection_reason
    return unless rejected? && rejection_reason.blank?

    errors.add(:rejection_reason, 'must be provided when rejecting the KYB application.')
  end

  def trigger_mail
    return unless previous_changes.key?(:status)

    if approved?
      KybApplicationMailer.approval_email(company).deliver_now
    elsif rejected?
      KybApplicationMailer.rejection_email(company, rejection_reason).deliver_now
    end
  end
end
