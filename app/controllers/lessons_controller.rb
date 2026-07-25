class LessonsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build
    authorize @lesson
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build(lesson_params)
    authorize @lesson
    if @lesson.save
      redirect_to course_path(@course), notice: "Lesson was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
    authorize @lesson
  end

  def update
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
    authorize @lesson

    if @lesson.update(lesson_params)
      redirect_to course_path(@course), notice: "Lesson was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end

  end

  private
  def lesson_params
    params.require(:lesson).permit(:title, :description, :start_time, :end_time)
  end
end