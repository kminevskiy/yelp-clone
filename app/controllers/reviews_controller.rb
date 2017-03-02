class ReviewsController < ApplicationController
  before_action :authenticated_user, only: [:create]

  def index
    @reviews = Review.last_six
  end

  def create
    business = Business.find(params[:review][:business_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.save
    redirect_to business_path(business)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :business_id)
  end
end
