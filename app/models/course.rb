class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_many :lessons, dependent: :destroy
  has_many :enrollments, through: :lessons
  enum :status, { draft: 0, published: 1 } # not used yet

  validates :title, :start_date, :end_date, :capacity, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  validate :end_date_after_start_date

  def self.ransackable_attributes(auth_object = nil)
    [ "title" ]
  end

  def visible_lessons_for(user)
    user&.teacher? ? lessons.order(start_time: :asc) : lessons.upcoming
  end

  def full?
    enrollments.where.not(status: :rejected).count >= capacity
  end

  def enrollable?
    !full?
  end

  def actual_capacity
    capacity - enrollments.where.not(status: :rejected).count
  end

  private
  def end_date_after_start_date
    errors.add(:end_date, "musi nastąpić po dacie startu") if end_date < start_date
  end
end
