class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.present? && user.student?
  end

  def destroy?
    user.present? && (user == record.user || user.admin?)
  end

  def update?
    user.present? && (user.teacher? || user.admin?)
  end

end