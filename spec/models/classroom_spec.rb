require 'rails_helper'

RSpec.describe Classroom, type: :model do
	let(:classroom) {FactoryGirl.create(:classroom)}
	before(:each) do
		@school = School.find(classroom.school_id)
	end

	describe 'attributes' do
		it { should belong_to :school }
	end

	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :student_count }
	end

	describe '#proportion_of_school' do
		it 'should return class proportion to school' do
			expect(classroom.proportion_of_school).to eq(classroom.student_count/@school.student_count)
		end
	end
end
