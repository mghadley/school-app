require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:school) {FactoryGirl.create(:school)}
  let(:classroom) {FactoryGirl.create(:classroom, school_id: school.id)}
  let(:classroom2) {FactoryGirl.create(:classroom, school_id: school.id)}

  describe "GET #index" do
    it "returns http success" do
      get :index, school_id: school.id
      expect(response).to have_http_status(:success)
    end

    it "assigns classrooms instance variable" do
      get :index, school_id: school.id
      expect(assigns(:classrooms)).to eq([])
    end

    it "has classrooms in classrooms instance variable" do
      school
      classroom
      classroom2
      get :index, school_id: school.id
      expect(assigns(:classrooms).count).to eq(2)
      expect(assigns(:classrooms).last.name).to eq(classroom2.name)
    end

    it "renders the index template" do
      get :index, school_id: school.id
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {school_id: school.id, id: classroom.id}
      expect(response).to have_http_status(:success)
    end

    it "assigns the classroom instance variable" do
      get :show, {school_id: school.id, id: classroom.id}
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the show template" do
      get :show, {school_id: school.id, id: classroom.id}
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, school_id: school.id
      expect(response).to have_http_status(:success)
    end

    it "assigns classroom instance variable" do
      get :new, school_id: school.id
      expect(assigns(:classroom).id).to be_nil
      expect(assigns(:classroom).class).to eq(Classroom)
    end

    it "assigns classroom instance variable to school" do
      get :new, school_id: school.id
      expect(assigns(:classroom).school_id).to eq(assigns(:school).id)
    end

    it "renders new template" do
      get :new, school_id: school.id
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before(:each) do
      @params = { school_id: school.id, classroom: { name: 'new class', student_count: 30 } }
      @failing_params = { school_id: school.id, classroom: { name: '', student_count: 30 } }
    end

    it "returns http redirect" do
      post :create, @params
      expect(response).to have_http_status(302)
    end

    it "creates a classroom" do
      expect(Classroom.count).to eq(0)
      post :create, @params
      expect(Classroom.last.name).to eq(@params[:classroom][:name])
    end

    it "assigns success flash on success" do
      post :create, @params
      expect(flash[:success]).to eq("Classroom created")
    end

    it "redirects to classroom path on success" do
      post :create, @params
      expect(response).to redirect_to(school_classroom_path(assigns(:school), assigns(:classroom)))
    end

    it "renders new template on failure" do
      post :create, @failing_params
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, { school_id: school.id, id: classroom.id }
      expect(response).to have_http_status(:success)
    end

    it "it finds the right classroom" do
      get :edit, { school_id: school.id, id: classroom.id }
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "renders the edit template" do
      get :edit, { school_id: school.id, id: classroom.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #udpate" do
    before(:each) do
      @params = { school_id: school.id, id: classroom.id, classroom: { name: 'updated class', student_count: 30 } }
      @failing_params = { school_id: school.id, id: classroom.id, classroom: { name: '', student_count: 30 } }
    end

    it "returns http redirect" do
      put :update, @params
      expect(response).to have_http_status(302)
    end

    it "assigns classroom instance variable" do
      put :update, @params
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "updates classroom" do
      put :update, @params
      expect(classroom.reload.name).to eq(@params[:classroom][:name])
    end

    it "redirects on success" do
      put :update, @params
      expect(response).to redirect_to(school_classroom_path(assigns(:school), assigns(:classroom)))
    end

    it "renders edit on failure" do
      put :update, @failing_params
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "has http redirect" do
      delete :destroy, { school_id: school.id, id: classroom.id }
      expect(response).to have_http_status(302)
    end

    it "assigns instance variable" do
      delete :destroy, { school_id: school.id, id: classroom.id }
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "deletes classroom" do
      school
      classroom
      expect(Classroom.count).to eq(1)
      delete :destroy, { school_id: school.id, id: classroom.id }
      expect(Classroom.count).to eq(0)
    end

    it "redirects to index" do
      delete :destroy, { school_id: school.id, id: classroom.id }
      expect(response).to redirect_to(school_classrooms_path(assigns(:school)))
    end
  end

end
