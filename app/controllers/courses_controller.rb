class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @courses = policy_scope(Course)
  end

  def show
    @course = Course.find(params[:id])
    authorize @course
  end
end
