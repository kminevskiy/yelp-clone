Fabricator(:business) do
  name { Faker::Company.name }
  phone_num { Faker::PhoneNumber.cell_phone }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
end
