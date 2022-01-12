class SessionsController < ApplicationController

  def new
    redirect_to user_path(current_user) if current_user
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:user_name] = user.fullname
      flash[:notice] = 'Logged in successfully'
      redirect_to user_path(user)
    else
      flash.now[:alert] = 'Wrong combination of email password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:notice] = 'Logged out successfully'
    redirect_to login_path
  end
end
