class Lesson < ApplicationRecord
  belongs_to :course
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments

  validates :title, :start_time, :end_time, presence: true
  validate :end_date_after_start_date

  scope :upcoming, -> { where("start_time >= ?", Time.current).order(start_time: :asc) }

  private
  def end_date_after_start_date
    return if start_time.blank? || end_time.blank?
    errors.add(:end_time, "must occur after start time") if end_time < start_time
  end
end
