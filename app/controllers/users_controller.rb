class UsersController < ApplicationController
  before_action :already_signed_in, only: [:new, :create]
  before_action :authenticated_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      flash[:error] = "Please check your input and try again"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
