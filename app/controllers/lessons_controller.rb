class LessonsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build(lesson_params)
    if @lesson.save
      redirect_to course_path(@course), notice: "Lesson was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit(:title, :description, :start_time, :end_time)
  end
end