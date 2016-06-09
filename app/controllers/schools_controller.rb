class SchoolsController < ApplicationController
	before_action :school_instance, except: [:index, :new, :create]
  def index
  	@schools = School.all
  end

  def show
  end

  def new
  	@school = School.new
  end

  def create
  	@school = School.new(school_params)
  	if @school.save
  		flash[:success] = "School created"
  		redirect_to school_path(@school)
  	else
  		flash[:danger] = @school.errors.full_messages.join('<br>').html_safe
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @school.update(school_params)
  		flash[:success] = "School updated"
  		redirect_to school_path(@school)
  	else
  		flash[:danger] = @school.errors.full_messages.join('<br>').html_safe
  		render :edit
  	end
  end

  def destroy
  	@school.destroy
  	flash[:success] = "School deleted"
  	redirect_to schools_path
  end

  private

  def school_instance
  	@school = School.find(params[:id])
  end

  def school_params
  	params.require(:school).permit(:name, :state, :capacity, :student_count)
  end
end
