class Classroom < ActiveRecord::Base
	belongs_to :school
	validates_presence_of :name, :student_count

	def proportion_of_school
		student_count/School.find(school_id).student_count
	end
end
