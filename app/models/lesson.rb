class Lesson < ApplicationRecord
  belongs_to :course
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments

  validates :title, :start_time, :end_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }

end
