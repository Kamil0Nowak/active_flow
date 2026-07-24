class LessonPolicy < ApplicationPolicy
  def create?
    user.present? && (user.teacher? || user.admin?)
  end

  def new?
    create?
  end

  def edit?
    user.present? && (user == record.course.teacher || user.admin?)
  end
end