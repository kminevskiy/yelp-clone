require "spec_helper"
require "rails_helper"

describe UsersController do
  describe "GET new" do
    context "with unauthenticated user" do
      it "renders the new user template" do
        get :new
        expect(response).to render_template :new
      end

      it "creates an empty user object" do
        get :new
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "with authenticated user" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end

      it "redirects to the home page" do
        get :new
        expect(response).to redirect_to home_path
      end
    end
  end

  describe "POST create" do
    context "with correct info" do
      before do
        post :create, params: { user: Fabricate.attributes_for(:user) }
      end

      it "redirects to the home page" do
        expect(response).to redirect_to login_path
      end

      it "creates a user" do
        expect(User.count).to eq(1)
      end
    end

    context "with incorrect info" do
      before do
        user = Fabricate(:user)
        post :create, params: { user: { email: user.email, full_name: "Bob", password: "bob12311" } }
      end

      it "does not create a user if supplied email exists" do
        expect(User.count).to eq(1)
      end

      it "re-renders the new template" do
        expect(response).to render_template :new
      end

      it "creates a flash error object" do
        expect(flash.now[:error]).to eq("Please check your input and try again.")
      end
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    context "with valid credentials" do
      before do
        session[:user_id] = user.id
      end

      it "renders the show template" do
        get :show, params: { id: user.id }
        expect(response).to render_template :show
      end

      it "sets appropriate user model" do
        get :show, params: { id: user.id }
        expect(assigns(:user)).not_to be_nil
      end
    end

    context "with invalid credentials" do
      it "redirects user to the login page" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to login_path
      end
    end
  end
end
