class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.present? && user.student?
  end

  def destroy?
    user.present? && (user == record.user || user.admin?)
  end
end