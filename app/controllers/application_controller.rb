class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :authenticated_user, :already_signed_in

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticated_user
    redirect_to login_path unless logged_in?
  end

  def already_signed_in
    redirect_to home_path if logged_in?
  end
end
