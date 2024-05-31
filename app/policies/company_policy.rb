# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  def index?
    user.company_owner?
  end

  def show?
    user.company_owner?
  end

  def create?
    user.company_owner?
  end

  def update?
    user.company_owner?
  end

  def destroy?
    user.company_owner?
  end

  def resubmit_kyb_application?
    user.company_owner?
  end
end
