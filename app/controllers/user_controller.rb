class UserController < ApplicationController
  def show
    @user = User.find_by(username: params[:username].downcase)
    @pagy, @slangs = pagy(Slang.where(user_id: @user.id).where(is_approved: true).order(created_at: :desc))
    return unless Current.user && (Current.user.id == @user.id || Current.user.is_admin)

    @pagy, @slangs = pagy(Slang.where(user_id: @user.id).order(created_at: :desc))
  end

  def settings
    @user = Current.user
  end

  def settings_update
    if Current.user.update(user_params)
      redirect_to settings_path, notice: 'Settings Updated'
    else
      redirect_to settings_path, notice: 'Issues'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
