class School < ActiveRecord::Base
	has_many :classrooms
	validates_presence_of :name, :capacity, :student_count

	def percent_full
		student_count/capacity
	end

	def school_size
		if capacity >= 4000
			"Large"
		else
			"Small"
		end
	end
end
