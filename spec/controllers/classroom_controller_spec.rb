require 'rails_helper'

RSpec.describe ClassroomController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      get :index, school_id: school
      expect(response).to have_http_status(:success)
    end

    it "assigns classrooms instance variable" do
      get :index
      expect(assigns(:classrooms)).to eq([])
    end

    it "has classrooms in classrooms instance variable" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      3.times { |i| school.classrooms.create(name: "test#{i}", student_count: 30)}
      get :index
      expect(assigns(:classrooms).count).to eq(3)
      expect(assigns(:classrooms).last.name).to eq("test2")
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "assigns the classroom instance variable" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      classroom = school.classrooms.create(name: 'test', student_count: 30)
      get :show, {school_id: school.id, id: classroom.id}
      expect(assigns(:classroom)).to eq(classroom)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
