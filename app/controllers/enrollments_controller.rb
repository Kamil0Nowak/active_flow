class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:create]
  before_action :set_enrollment, only: [:destroy]

  def create
    @enrollment = @lesson.enrollments.build(user: current_user)
    authorize @enrollment

    if @enrollment.save
      # redirect_to course_path(@lesson.course), notice: "Zapisano na lekcję!"
      render partial: "enrollments/button", locals: { lesson: @lesson }
    else
      # redirect_to course_path(@lesson.course), alert: "Nie udało się zapisać: #{@enrollment.errors.full_messages.join(', ')}"
      render partial: "enrollments/button", locals: { lesson: @lesson }
    end
  end

  def destroy
    authorize @enrollment
    @enrollment.destroy
    @lesson = @enrollment.lesson
    render partial: "enrollments/button", locals: { lesson: @lesson }
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_enrollment
    @enrollment = current_user.enrollments.find(params[:id])
  end
end