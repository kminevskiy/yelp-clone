require "spec_helper"
require "rails_helper"

describe BusinessesController do
  describe "GET index" do
    let(:user) { Fabricate(:user) }

    it "creates businesses instance variable" do
      mexican = Fabricate(:category)
      fast_food = Fabricate(:category)
      business1 = Fabricate(:business, user: user, categories: [mexican])
      business2 = Fabricate(:business, user: user, categories: [fast_food])

      get :index
      expect(assigns(:businesses)).to eq([business1, business2])
    end

    it "renders the index template" do
      mexican = Fabricate(:category)
      Fabricate(:business, user: user, categories: [mexican])

      get :index
      expect(response).to render_template :index
    end

    it "displays an empty businesses stub if there are no businesses" do
      get :index
      expect(response).to render_template :stub
    end
  end

  describe "GET show" do
    let(:business) { Fabricate(:business, user: Fabricate(:user), categories: [Fabricate(:category)]) }

    before do
      get :show, params: { id:  business.id }
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "sets the appropriate business model" do
      expect(assigns(:business)).to eq(business)
    end
  end

  describe "GET new" do
    let(:user) { Fabricate(:user) }

    context "with valid credentials" do
      before do
        session[:user_id] = user.id
      end

      it "requires a logged in user to access the new business form" do
        get :new
        expect(response).to render_template :new
      end

      it "create a new empty object of Business class" do
        get :new
        expect(assigns(:business)).to be_instance_of(Business)
      end

      it "render the new business template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "with invalid credentials" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }
    let(:mexican) { Fabricate(:category) }
    let(:fast_food) { Fabricate(:category) }

    context "with valid credentials" do
      before do
        session[:user_id] = user.id
        post :create, params: { business: { name: "Restaurant", address: "1234 Baker Str", phone_num: "555-555-5555", city: "Portland", state: "Oregon", category_ids: [mexican.id, fast_food.id] } }
      end

      it "creates new business record" do
        expect(Business.count).to eq(1)
      end

      it "redirects to home page" do
        expect(response).to redirect_to home_path
      end

      it "associates business with user" do
        expect(Business.first.user).to eq(user)
      end

      it "associates business with categories" do
        expect(Business.first.categories).to eq([mexican, fast_food])
      end
    end

    context "with invalid input" do
      let(:mexican) { Fabricate:category }
      let(:fast_food) { Fabricate:category }

      before do
        session[:user_id] = user.id
        post :create, params: { business: { name: "", address: "1234 Baker Str", phone_num: "555-555-5555", city: "Portland", state: "Oregon", category_ids: [mexican.id, fast_food.id] } }
      end

      it "requires all attributes to be present" do
        expect(Business.count).to eq(0)
      end

      it "re-renders the new template" do
        expect(response).to render_template :new
      end

      it "creates a flash error object" do
        expect(flash[:error]).not_to be_nil
      end
    end

    context "with unauthenticated user" do
      it "requires logged in user" do
        post :create, params: { business: Fabricate.attributes_for(:business) }
        expect(response).to redirect_to login_path
      end
    end
  end
end
