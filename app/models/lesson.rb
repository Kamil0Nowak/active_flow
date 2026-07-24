class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, :start_time, :end_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }
end
