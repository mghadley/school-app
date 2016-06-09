require 'rails_helper'

RSpec.describe Classroom, type: :model do
	describe 'attributes' do
		it { should belong_to :school }
	end

	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :student_count }
	end

	describe '#proportion_of_school' do
		it 'should return class proportion to school' do
			school = School.create(name: 'test', capacity: 5000, student_count: 2500)
			classroom = school.classrooms.create(name: 'test', student_count: 30)
			expect(classroom.proportion_of_school).to eq(classroom.student_count/school.student_count)
		end
	end
end
