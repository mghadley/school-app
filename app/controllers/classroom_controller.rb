class ClassroomController < ApplicationController
  def index
  	@classrooms = Classroom.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
