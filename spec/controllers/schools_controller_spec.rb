require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "set schools instance variable" do
      get :index
      expect(assigns(:schools)).to eq([])
    end

    it "has schools in the schools instance variable" do
      3.times { |i| School.create(name: "name#{i}", capacity: 5000, student_count: 25000)}
      get :index
      expect(assigns(:schools).length).to eq(3)
      expect(assigns(:schools).last.name).to eq(School.last.name)
    end

    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      get :show, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "sets school instance variable" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      get :show, id: school.id
      expect(assigns(:school)).to eq(school) 
    end

    it "renders show template" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      get :show, id: school.id
      expect(response).to render_template(:show)
    end  
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      get :new
      expect(assigns(:school)).to_not eq(nil)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      school = School.create(name: 'test', capacity: 5000, student_count: 2500)
      get :edit, id: school.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do

    it "sets the school instance variable" do
      school_params = {school: {name:'test', capacity: 5000, student_count: 2500 }}
      post :create, school_params
      expect(assigns(:school).name).to eq(school_params[:school][:name])
    end

    it "creates a new school" do
      school_params = {school: {name:'test', capacity: 5000, student_count: 2500 }}
      expect(School.count).to eq(0)
      post :create, school_params
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(school_params[:school][:name])
    end

    it "sets success flash message on success" do
      school_params = {school: {name:'test', capacity: 5000, student_count: 2500 }}
      post :create, school_params
      expect(flash[:success]).to eq('School created')
    end

    it "redirects to school show path on success" do
      school_params = {school: {name:'test', capacity: 5000, student_count: 2500 }}
      post :create, school_params
      expect(response).to redirect_to(school_path(School.first))
    end

    it "sets danger flash message on failure" do
      school_params = {school: {name:'', capacity: 5000, student_count: 2500 }}
      post :create, school_params
      expect(flash[:danger]).to eq(assigns(:school).errors.full_messages.join('<br>').html_safe)
    end

    it "renders new template on failure" do
      school_params = {school: {name:'', capacity: 5000, student_count: 2500 }}
      post :create, school_params
      expect(response).to render_template(:new)
    end
  end

  describe "PUT #update" do
    it "sets the school instance variable" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      put :update, {id: school.id, school: {name:'updated', capacity: 5000, student_count: 2500 }}
      expect(assigns(:school)).to eq(school)
    end

    it "updates the school" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      put :update, {id: school.id, school: {name:'updated', capacity: 5000, student_count: 2500 }}
      expect(school.reload.name).to eq('updated')
    end

    it "sets success flash message on success" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      put :update, {id: school.id, school: {name:'updated', capacity: 5000, student_count: 2500 }}
      expect(flash[:success]).to eq("School updated")
    end

    it "redirects to school path on success" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      put :update, {id: school.id, school: {name:'updated', capacity: 5000, student_count: 2500 }}
      expect(response).to redirect_to(school_path(School.last))
    end

    it "sets danger flash message on failure" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      put :update, {id: school.id, school: {name:'', capacity: 5000, student_count: 2500 }}
      expect(flash[:danger]).to eq(assigns(:school).errors.full_messages.join('<br>').html_safe)
    end

    it "renders edit template on failure" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      put :update, {id: school.id, school: {name:'', capacity: 5000, student_count: 2500 }}
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "assigns school instance variable" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      delete :destroy, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it "deletes school" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      expect(School.count).to eq(1)
      delete :destroy, id: school.id
      expect(School.count).to eq(0)
    end

    it "sets the flash message" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      delete :destroy, id: school.id
      expect(flash[:success]).to eq("School deleted")
    end

    it "redirects to index path" do
      school = School.create(name:'test', capacity: 5000, student_count: 2500)
      delete :destroy, id: school.id
      expect(response).to redirect_to(schools_path)
    end
  end

end
