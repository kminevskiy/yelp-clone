require "spec_helper"
require "rails_helper"

describe ReviewsController do
  describe "POST create" do
    context "with valid credentials" do
      let(:user) { Fabricate(:user) }
      let(:restaurant) { Fabricate(:category) }
      let(:business) { Fabricate(:business, user: user, categories: [restaurant]) }

      before do
        session[:user_id] = user.id
      end

      it "adds a review for a business" do
        post :create, params: { review: { business_id: business.id, user: user, comment: Faker::Lorem.paragraph, rating: 1 } }
        expect(Review.count).to eq(1)
      end

      it "associates a review with a business" do
        post :create, params: { review: { business_id: business.id, user: user, comment: Faker::Lorem.paragraph, rating: 1 } }
        expect(business.reviews.size).to eq(1)
      end

      it "associates a review with a user" do
        post :create, params: { review: { business_id: business.id, user: user, comment: Faker::Lorem.paragraph, rating: 1 } }
        expect(user.reviews.size).to eq(1)
      end

      it "creates only one review per user" do
        Fabricate(:review, user: user, business: business)
        Fabricate(:review, user: Fabricate(:user), business: business)
        post :create, params: { review: { business_id: business.id, user: user, comment: Faker::Lorem.paragraph, rating: 1 } }
        expect(Review.count).to eq(2)
      end
    end

    context "with invalid credentials" do
      let(:user) { Fabricate(:user) }
      let(:restaurant) { Fabricate(:category) }
      let(:business) { Fabricate(:business, user: user, categories: [restaurant]) }

      before do
        post :create, params: { review: { business_id: business.id, user: user, comment: Faker::Lorem.paragraph, rating: 1 } }
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end

      it "does not create a new review" do
        expect(Review.count).to eq(0)
      end
    end
  end

  describe "GET index" do
    let(:user) { Fabricate(:user) }

    context "with existins business and review" do
      it "renders the index page if both review and business present" do
        business = Fabricate(:business, user: user, categories: [Fabricate(:category)])
        Fabricate(:review, business: business, user: user)
        get :index
        expect(response).to render_template :index
      end

      it "sets the reviews collection with appropriate model" do
        business = Fabricate(:business, user: user, categories: [Fabricate(:category)])
        Fabricate(:review, business: business, user: user)
        get :index
        expect(assigns(:reviews).first).to be_instance_of(Review)
      end

      it "set the reviews collection" do
        user2 = Fabricate(:user)
        business1 = Fabricate(:business, user: user, categories: [Fabricate(:category)])
        business2 = Fabricate(:business, user: user2, categories: [Fabricate(:category)])
        Fabricate(:review, business: business1, user: user)
        Fabricate(:review, business: business2, user: user2)
        get :index
        expect(assigns(:reviews).count).to eq(2)
      end
    end

    context "without business and review" do
      it "redirects to the home page if no reviews/businesses preset" do
        get :index
        expect(response).to redirect_to add_business_path
      end
    end
  end
end
