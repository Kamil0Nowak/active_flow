class CoursesController < ApplicationController
  def index
    @courses = Course.published.all
  end

  def show
    @course = Course.find(params[:id])
  end
end
