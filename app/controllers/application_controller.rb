 class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def authentication_required
    redirect_to login_path unless logged_in?
  end

  def can_current_user?(action, object)
    object.send("#{action}able_by?", current_user)  
  end

  def logged_in?
    !!current_user
  end

  def login_required
    if !logged_in
      redirect_to login_path, :notices => "Please login first!"
    end
  end

  def current_user
    User.find_by(id: session[:user_id])  if session[:user_id]
  end

end
