def add_business(company_name, option)
  visit add_business_path
  fill_in "Business Name", with: company_name
  fill_in "Phone #", with: Faker::PhoneNumber.cell_phone
  fill_in "Address", with: Faker::Address.street_name
  fill_in "City", with: Faker::Address.city
  fill_in "State", with: Faker::Address.state
  select option, from: "Categories (multi-select)"
  click_button "Add business"
end
