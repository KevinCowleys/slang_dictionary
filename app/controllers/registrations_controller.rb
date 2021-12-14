class RegistrationsController < ApplicationController
  # instantiates new user
  def new
    return redirect_to root_path if Current.user

    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # stores saved user id in a session
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully created account'
    else
      render :new, alert: @user.errors.messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
