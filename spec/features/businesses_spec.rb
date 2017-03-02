require "spec_helper"
require "rails_helper"

feature "Businesses displayed" do
  let(:user) { Fabricate(:user) }

  scenario "when user visits the home path" do
    business = Fabricate(:business, user: Fabricate(:user), categories: [Fabricate(:category)])
    visit home_path
    expect(page).to have_content(business.name)
  end

  scenario "when user visits the home path with no businesses" do
    visit home_path
    expect(page).to have_content("Add first")
  end

  feature "User creates a business" do
    before do
      Fabricate(:category, name: "Sports")
    end

    scenario "with valid credentials" do
      company_name = Faker::Company.name
      log_in(user)
      add_business(company_name, "Sports")
      expect(page).to have_content(company_name)
    end
  end
end
