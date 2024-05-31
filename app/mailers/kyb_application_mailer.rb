# frozen_string_literal: true

class KybApplicationMailer < ApplicationMailer
  def approval_email(company)
    @company = company
    mail(to: @company.email, subject: 'KYB Application Approved')
  end

  def rejection_email(company, reason)
    @company = company
    @reason = reason
    mail(to: @company.email, subject: 'KYB Application Rejected')
  end
end
