require 'rails_helper'

feature 'Classroom Show', js: true do
	let(:classroom) { FactoryGirl.create(:classroom) } 
	before(:each) do
		@school = School.find(classroom.school_id)
		visit school_classroom_path(@school, classroom)
	end

	scenario 'displays classroom info' do
		expect(find('#belongs-to-school').text).to eq(@school.name)
		expect(find('#subject').text).to eq("Subject: #{classroom.subject}")
		expect(find('#student-count').text).to eq("Student Count: #{classroom.student_count}")
	end

	scenario 'can navigate back to school' do
		find('#belongs-to-school').click
		expect(find('#school-heading').text).to eq(@school.name)
	end
end