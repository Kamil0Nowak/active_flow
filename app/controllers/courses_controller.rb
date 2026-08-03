class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :manage_enrollments]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @q = policy_scope(Course).ransack(params[:q])
    @courses = @q.result(distinct: true).page(params[:page]).per(3)
  end

  def show
    authorize @course

    @lessons = @course.visible_lessons_for(current_user)
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

  def edit
    authorize @course
  end

  def update
    authorize @course
    if @course.update(course_params)
      redirect_to courses_path, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @course
    @course.destroy
    redirect_to courses_path, notice: "Course was successfully destroyed."
  end

  def manage_enrollments
    authorize @course, :manage_enrollments?
  end

  private
  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date, :capacity)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
