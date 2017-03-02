def create_review(company_name, review_comment)
  click_link company_name
  fill_in "Review", with: review_comment
  select "5", from: "Rating"
  click_button "Add review"
end
