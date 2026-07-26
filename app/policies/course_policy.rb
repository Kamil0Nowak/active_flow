class CoursePolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user.present? && (user.admin? || user.teacher?)
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (record.teacher == user || user.admin?)
  end

  def destroy?
    update?
  end

  def manage_enrollments?
    update?
  end

  class Scope < Scope
    def resolve
      if user&.teacher?
        scope.where(teacher: user)
      else
        scope.all
      end
    end
  end
end

