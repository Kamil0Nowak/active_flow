class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @courses = policy_scope(Course)
  end

  def show
    @course = Course.find(params[:id])
    authorize @course
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = current_user.courses.build(course_params)
    authorize @course
    if @course.save
      redirect_to courses_path, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date, :capacity)
  end
end
