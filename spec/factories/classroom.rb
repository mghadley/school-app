FactoryGirl.define do
	factory :classroom do
		sequence :name do |n|
			"school_#{n}"
		end
		subject "Matt"
		student_count 30
		school
	end
end