Fabricator(:review) do
  comment { Faker::Lorem.paragraph }
  rating { rand(1..5) }
end
