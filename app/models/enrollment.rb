class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  enum :status, { pending: 0, confirmed: 1, rejected: 2 }, default: :pending

  validates :user_id, uniqueness: { scope: :lesson_id, message: "already enrolled in this lesson" }

  validate :lesson_not_full, on: :create

  private

  def lesson_not_full
    return unless lesson && lesson.course.full?
    errors.add(:lesson, "is full")
  end
end