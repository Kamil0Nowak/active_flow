class LessonsController < ApplicationController
  before_action :set_course, only: [:new, :create]
  before_action :set_course_and_lesson, only: [:edit, :update, :destroy]

  def new
    @lesson = @course.lessons.build
    authorize @lesson
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    authorize @lesson
    if @lesson.save
      flash.now[:notice] = "Lesson was successfully created."
      render turbo_stream: [
        turbo_stream.prepend("lessons", partial: "lessons/lesson", locals: { lesson: @lesson }),
        turbo_stream.update("new_lesson", ""),
        turbo_stream.update("toast_container", partial: "shared/flash")
      ]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @lesson
  end

  def update
    authorize @lesson
    if @lesson.update(lesson_params)
      flash.now[:notice] = "Lesson was successfully updated."
      render turbo_stream: [
        turbo_stream.replace(helpers.dom_id(@lesson), partial: "lessons/lesson", locals: { lesson: @lesson }),
        turbo_stream.update("new_lesson", ""),
        turbo_stream.update("toast_container", partial: "shared/flash")
      ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @lesson
    @lesson.destroy
    redirect_to course_path(@course), notice: "Lesson was successfully destroyed."
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :description, :start_time, :end_time)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_course_and_lesson
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
  end
end