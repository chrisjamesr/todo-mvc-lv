
class SessionsController < ApplicationController

  def new

  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      
      #logged in via omniauth
     oauth_email = request.env["omniauth.auth"]["info"]["email"]
     if user = User.find_by(:email => oauth_email)
        session[:user_id] = user.id
        redirect_to root_path
      else
        user = User.new(:email => oauth_email, :password => SecureRandom.hex)
        if user.save
          session[:user_id] = user.id
          redirect_to root_path
        else
          raise user.errors.full_messages.inspect 
        end
      end
    elsif
      user = User.find_by(:email => params[:email])
        #normal login with username & pw
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to root_path 
        end
      else  
        render 'sessions/new'
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end 
  

  private
    # def auth
    #   request.env['omniauth.auth']
    # end
end
