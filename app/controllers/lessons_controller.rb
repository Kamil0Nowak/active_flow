class LessonsController < ApplicationController
  before_action :set_course_and_lesson, only: [ :create, :edit, :update, :destroy]
  def new
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build
    authorize @lesson
  end

  def create
    authorize @lesson
    if @lesson.save
      redirect_to course_path(@course), notice: "Lesson was successfully created."
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
      redirect_to course_path(@course), notice: "Lesson was successfully updated."
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

  def set_course_and_lesson
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
  end
end