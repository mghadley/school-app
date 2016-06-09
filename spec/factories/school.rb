FactoryGirl.define do
	factory :school, class: School do
		sequence :name do |n|
			"school_#{n}"
		end
		state 'UT'
		capacity 5000
		student_count 4000
		trait :small do
			capacity 3000
			student_count 15000
		end
	end
end