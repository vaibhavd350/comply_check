# frozen_string_literal: true

class KybApplicationPolicy < ApplicationPolicy
  def index?
    user.compliance_officer?
  end

  def show?
    user.compliance_officer?
  end

  def approve?
    user.compliance_officer?
  end

  def reject?
    user.compliance_officer?
  end

  def resubmit_kyb_application?
    user.company_owner?
  end
end
