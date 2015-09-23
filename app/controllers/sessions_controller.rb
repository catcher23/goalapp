class SessionsController < ApplicationController
  # before_action :ensure_signed_out

  def new
    @user = User.new
  end

  def create

    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login(@user)
      redirect_to @user
    else
      @user = User.new
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private

  # def ensure_signed_out
  #   redirect_to user_url(current_user) if logged_in?
  # end
end
