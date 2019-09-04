class SessionsController < ApplicationController
  attr_reader :password

  def new 
    
  end

  def create
    current_user ||= User.find_by_credentials(params[:user][:username], params[:user][:password])
    sessions[:session_token] = current_user.reset_session_token!
    redirect_to cats_url
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      @current_user = nil
      session[:session_token] = nil
    end
    redirect_to cats_url
  end
  

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  # def ensure_session_token
  #   self.session_token ||= self.class.generate_session_token
  # end

  # def password=(password)
  #   @password = password
  #   self.password_digest = BCrypt::Password.create(password)
  # end

  # def is_password?(password)
  #   BCrypt::Password.new(self.password_digest).is_password?(password)
  # end

  # def self.find_by_credentials(username, password)
  #   user = User.find_by(user_name: username)
  #   return user if user.is_password?(password)
   
  # end
end