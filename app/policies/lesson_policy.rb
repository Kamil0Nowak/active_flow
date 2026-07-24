class LessonPolicy < ApplicationPolicy
  def create?
    user.present? && (user.teacher? || user.admin?)
  end

  def new?
    create?
  end
end