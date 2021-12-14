class AdminController < ApplicationController
  def show
    return redirect_back fallback_location: root_path unless Current.user.is_admin

    @pagy, @slangs = pagy(Slang.where(is_approved: false).order(created_at: :desc))
    @vote = Current.user.votes.new
  end

  def approve
    return redirect_back fallback_location: root_path unless Current.user.is_admin

    slang = Slang.find_by(id: params[:slang_id])
    slang.is_approved = true

    if slang.save
      redirect_to admin_path, notice: 'Slang Approved'
    else
      redirect_to admin_path, notice: 'Issues'
    end
  end

  def destroy
    return redirect_back fallback_location: root_path unless Current.user.is_admin

    slang = Slang.find_by(id: params[:slang_id])

    if slang.destroy
      redirect_to admin_path, notice: 'Slang Approved'
    else
      redirect_to admin_path, notice: 'Issues'
    end
  end
end
