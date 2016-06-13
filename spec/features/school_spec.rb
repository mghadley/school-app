require 'rails_helper'

feature 'School Show', js: true do
	
	context 'no classrooms' do
		let(:school) { FactoryGirl.create(:school) }
		before(:each) do
			visit(school_path(school))
		end

		scenario 'has school name as header' do
			expect(find('#school-heading').text).to eq(school.name)
		end

		scenario 'lists school attributes' do
			expect(find('#state').text).to eq("Located in #{school.state}")
			expect(find('#capacity').text).to eq("Capacity: #{school.capacity} students")
			expect(find('#student-count').text).to eq("Current number of students: #{school.student_count}")
		end

		scenario 'adds a classroom' do
			expect(school.classrooms.count).to eq(0)
			find('#new-classroom-btn').click
			fill_in('classroom[name]', with: 'test classroom')
			fill_in('classroom[subject]', with: 'math')
			fill_in('classroom[student_count]', with: 30)
			find('#create-classroom-btn').click
			expect(school.classrooms.count).to eq(1)
			expect(find('#classroom-heading').text).to eq(school.classrooms.first.name)
		end
	end

	context 'has classrooms' do
		let(:school) {FactoryGirl.create(:school)}
	  let(:classroom) {FactoryGirl.create(:classroom, school_id: school.id)}
	  let(:classroom2) {FactoryGirl.create(:classroom, school_id: school.id)}
	  before(:each) do
	  	classroom
	  	classroom2
	  	visit(school_path(school))
	  end

		scenario 'displays classrooms' do
			expect(first('.classroom-name').text).to eq(classroom.name)
			expect(page).to have_css('.classroom-name', count: school.classrooms.count)
		end

		scenario 'can navigate to classroom' do
			first('.classroom-name').click
			expect(find('#classroom-heading').text).to eq(classroom.name)
		end
	end

end