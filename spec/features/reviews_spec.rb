require "spec_helper"
require "rails_helper"

feature "User leaves a review" do
  let(:user) { Fabricate(:user) }

  before do
    Fabricate(:category, name: "Sports")
  end

  scenario "for existing business" do
    company_name = Faker::Company.name
    review_comment = "A very good company"
    log_in(user)
    add_business(company_name, "Sports")
    create_review(company_name, review_comment)
    expect(page).to have_content(review_comment)
  end
end
