class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  def new
    @user = User.new
  end

  def create
    # binding.break
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You have successfully signed up'
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @user.update(user_params);
    if @user.save
      flash[:notice] = 'Your account info successfully updated'
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :fullname, :email, :password)
  end
end
