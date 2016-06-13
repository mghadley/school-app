require 'rails_helper'

feature 'Schools Index', js: true do
	
	context 'no schools' do
		scenario 'has header' do
			visit root_path
			expect(find('#schools-header').text).to eq('All Schools')
		end

		scenario 'shows no schools message' do
			visit root_path
			expect(find('#no-schools').text).to eq("No schools yet :/")
		end

		scenario 'creates new school' do
			visit root_path
			expect(School.count).to eq(0)
			find('#new-school-btn').click
			fill_in('school[name]', with: 'test school')
			fill_in('school[capacity]', with: 5000)
			fill_in('school[student_count]', with: 2500)
			find('#create-school-btn').click
			expect(School.count).to eq(1)
			expect(first('#school-heading').text).to eq(School.first.name)
		end
	end

	context 'with schools' do

		scenario 'displays school' do
			schools = create_list(:school, 5)
			visit schools_path
			expect(first('#school-title').text).to eq(School.first.name)
		end
	end
end