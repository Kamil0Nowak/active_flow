class CoursePolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user.present? && (user.admin? || user.teacher?)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

