require "spec_helper"
require "rails_helper"

feature "User logs in" do
  scenario "with existing user credentials" do
    user = Fabricate(:user)
    log_in(user)
    expect(page).to have_content(user.full_name)
  end

  scenario "with invalid user credentials" do
    user = Fabricate(:user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password + "123"
    click_button "Log in"
    expect(page).to have_content("Log in")
  end
end
