require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) {FactoryGirl.create(:school)}
  let(:small_school) {FactoryGirl.create(:school, :small)}

  describe 'attributes' do 
    it {should have_many(:classrooms)}
  end

  describe 'validations' do
  	it { should validate_presence_of :name}
  	it { should validate_presence_of :capacity}
  	it { should validate_presence_of :student_count}
  end

  describe '#percent_full' do
  	it 'returns the ratio of the school that is full' do
  		expect(school.percent_full).to eq(school.student_count/school.capacity)
  	end
  end

  describe '#school_size' do
  	it 'returns large for size of school' do
  		expect(school.school_size).to eq('Large')
  	end
  	it 'returns small for size of school' do
  		expect(small_school.school_size).to eq('Small')
  	end
  end
end
