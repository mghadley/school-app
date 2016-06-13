class ClassroomsController < ApplicationController
	before_action :school_instance
	before_action :classroom_instance, except: [:new, :index, :create]

  def index
  	@classrooms = @school.classrooms.all
  end

  def show
  end

  def new
  	@classroom = @school.classrooms.new
  end

  def create
  	@classroom = @school.classrooms.new(classroom_params)
  	if @classroom.save
  		flash[:success] = 'Classroom created'
  		redirect_to school_classroom_path(@school, @classroom)
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @classroom.update(classroom_params)
  		redirect_to school_classroom_path(@school, @classroom)
  	else
  		render :edit
  	end
  end

  def destroy
  	@classroom.destroy
  	redirect_to school_classrooms_path(@school)
  end

  private

  def classroom_params
  	params.require(:classroom).permit(:name, :student_count, :subject)
  end

  def school_instance
  	@school = School.find(params[:school_id])
  end

  def classroom_instance
  	@classroom = @school.classrooms.find(params[:id])
  end
end
