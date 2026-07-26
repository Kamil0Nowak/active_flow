class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_many :lessons, dependent: :destroy
  has_many :enrollments, through: :lessons
  enum :status, { draft: 0, published: 1 }

  validates :title, :start_date, :end_date, :capacity, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  validate :end_date_after_start_date

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  def full?
    enrollments.confirmed.count >= capacity
  end

  def enrollable?
    !full?
  end

  private
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after start date") if end_date < start_date
  end
end
