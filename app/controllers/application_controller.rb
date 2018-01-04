class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def authentication_required
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])  if session[:user_id]
  end

end
