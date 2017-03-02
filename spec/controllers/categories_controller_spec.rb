require "spec_helper"
require "rails_helper"

describe CategoriesController do
  describe "GET index" do
    before do
      get :index
    end
    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "sets the categories variable" do
      expect(assigns(:categories)).not_to be_nil
    end

    it "makes sure categories contain Category models" do
      Fabricate(:category)
      expect(assigns(:categories).first).to be_instance_of(Category)
    end
  end

  describe "GET show" do
    let(:category) { Fabricate(:category) }

    before do
      get :show, params: { id: category.id }
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "sets the category variable" do
      expect(assigns(:category)).not_to be_nil
    end

    it "makes sure the category variable is an instance of Category class" do
      expect(assigns(:category)).to be_instance_of(Category)
    end
  end
end
