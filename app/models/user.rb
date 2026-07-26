class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { user: 0, teacher: 1, admin: 2 }

  validates :role, :first_name, :last_name, presence: true

  has_many :courses, foreign_key: :teacher_id
  has_many :enrollments
  has_many :lessons, through: :enrollments

  def enrolled_in_lesson?(lesson)
    enrollments.exists?(lesson_id: lesson.id)
  end

  def enrollment_for_lesson(lesson)
    enrollments.find_by(lesson_id: lesson.id)
  end
  def full_name
    "#{first_name} #{last_name}"
  end

  def student?
    role == "user"
  end
end
