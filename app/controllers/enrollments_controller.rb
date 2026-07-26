class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:create]
  before_action :set_enrollment, only: [ :update ]

  def create
    @enrollment = @lesson.enrollments.build(user: current_user)
    authorize @enrollment

    if @enrollment.save
      render partial: "enrollments/button", locals: { lesson: @lesson }
    else
      render partial: "enrollments/button", locals: { lesson: @lesson }
    end
  end

  def destroy
    @enrollment = current_user.enrollments.find(params[:id])
    authorize @enrollment
    @enrollment.destroy
    @lesson = @enrollment.lesson
    render partial: "enrollments/button", locals: { lesson: @lesson }
  end

  def update
    authorize @enrollment
    if @enrollment.update(enrollment_params)
      redirect_to manage_enrollments_course_path(@enrollment.lesson.course), notice: "Status zapisu zaktualizowany."
    else
      redirect_to manage_enrollments_course_path(@enrollment.lesson.course), alert: "Nie udało się zmienić statusu."
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  def enrollment_params
    params.permit(:status)
  end
end