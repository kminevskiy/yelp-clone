require "spec_helper"
require "rails_helper"

describe SessionsController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with correct credentials" do
      let(:user) { Fabricate(:user) }

      before do
        post :create, params: { email: user.email, password: user.password }
      end

      it "creates new session for authenticated user" do
        expect(session[:user_id]).not_to be_nil
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with incorrect credentials" do
      let(:user) { Fabricate(:user) }

      before do
        post :create, params: { email: user.email, password: "mismatched" }
      end

      it "re-renders the new template with incorrect credentials supplied" do
        expect(response).to render_template :new
      end
      it "create a flash error object" do
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
