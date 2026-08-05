class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:create]
  before_action :set_enrollment, only: [ :update ]

  def create
    @enrollment = @lesson.enrollments.build(user: current_user)
    authorize @enrollment

    if @enrollment.save
      flash.now[:notice] = "Zapisano się na lekcję."
      render turbo_stream: [
        turbo_stream.replace(helpers.dom_id(@lesson, :enrollment_button), partial: "enrollments/button", locals: { lesson: @lesson }),
        turbo_stream.update("toast_container", partial: "shared/flash")
      ]
    else
      flash.now[:alert] = "Nie udało się zapisać na lekcję."
      render turbo_stream: [
        turbo_stream.update("toast_container", partial: "shared/flash")
      ]
    end
  end

  def destroy
    @enrollment = current_user.enrollments.find(params[:id])
    authorize @enrollment
    @enrollment.destroy
    @lesson = @enrollment.lesson

    flash.now[:notice] = "Usunięto zapis na lekcję."
    render turbo_stream: [
      turbo_stream.replace(helpers.dom_id(@lesson, :enrollment_button), partial: "enrollments/button", locals: { lesson: @lesson }),
      turbo_stream.update("toast_container", partial: "shared/flash")
    ]
  end

  def update
    authorize @enrollment
    if @enrollment.update(enrollment_params)
      flash.now[:notice] = "Status zmieniony."
      render turbo_stream: [
        turbo_stream.replace("enrollment-#{@enrollment.id}", partial: "courses/manage_lesson", locals: { enrollment: @enrollment }),
        turbo_stream.update("toast_container", partial: "shared/flash")
      ]
    else
      flash.now[:notice] = "Status zmieniony."
      render turbo_stream: turbo_stream.update("toast_container", partial: "shared/flash")
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