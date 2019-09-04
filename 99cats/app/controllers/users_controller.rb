class UsersController < ApplicationController

  def new
      render :new
  end

  def create
    @user = User.new(user_params)
    if User.find_by(user_name: @user.user_name) && User.find_by(user_name: @user.user_name).is_password?(user_params[:password])
      session[:session_token] = User.find_by(user_name: @user.user_name).reset_session_token!
      redirect_to cats_url
      return
    elsif User.find_by(user_name: @user.user_name)
      flash.now[:errors] = ['Invalid Password']
      render :new
      return
    elsif @user.save
      # @user.password=(user_params[:password])
      session[:session_token] = @user.session_token
      redirect_to cats_url
      return
    else
      flash.now[:errors] = ['Invalid Credentials']
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end