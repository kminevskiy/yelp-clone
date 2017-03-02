def log_in(user=nil)
  current_user = user ||  Fabricate(:user)
  visit login_path
  fill_in "Email", with: current_user.email
  fill_in "Password", with: current_user.password
  click_button "Log in"
end
