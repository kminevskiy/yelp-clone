class BusinessesController < ApplicationController
  before_action :authenticated_user, only: [:new, :create]

  def index
    @businesses = Business.all
    @businesses.present? ? render(:index) : render("shared/stub")
  end

  def show
    @business = Business.find(params[:id])
    @review = Review.new(business: @business)
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    @business.user = current_user

    if @business.save
      redirect_to home_path
    else
      flash.now[:error] = "Please check your input and try again."
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :phone_num, :address, :city, :state, category_ids: [])
  end
end
