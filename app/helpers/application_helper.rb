module ApplicationHelper
  def show_star_rating(business)
    base_path = "/images/yelp_stars/web_and_ios/regular/"
    case business.rating.to_f
      when 0 then base_path + "regular_0.png"
      when 1 then base_path + "regular_1.png"
      when 1...2 then base_path + "regular_1_half.png"
      when 2 then base_path + "regular_2.png"
      when 2...3 then base_path + "regular_2_half.png"
      when 3 then base_path + "regular_3.png"
      when 3...4 then base_path + "regular_3_half.png"
      when 4 then base_path + "regular_4.png"
      when 4...5 then base_path + "regular_4_half.png"
      when 5 then base_path + "regular_5.png"
    end
  end

  def create_categories_links(business)
    business.categories.map do |category|
      link_to category.name, category
    end.join(", ").html_safe
  end

  def full_address(business)
    "#{business.address}, #{business.city}, #{business.state}"
  end

  def format_date(date)
    date.in_time_zone("Eastern Time (US & Canada)").strftime("%d/%m/%Y")
  end

  def reviews_exist?
    Review.any?
  end
end
