class SessionsController < ApplicationController
  before_action :already_signed_in, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Incorrect email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end
end
