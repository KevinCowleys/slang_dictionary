# Current.user.id
class SlangsController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @slang = Current.user.slangs.new
  end

  def create
    @slang = Current.user.slangs.new(slang_params)
    if @slang.save
      redirect_to root_path, notice: 'Successfully created post'
    else
      redirect_to root_path, alert: @post.errors.messages
    end
  end

  def like
    return redirect_to log_in_path, notice: 'You need to sign in to vote' unless Current.user

    slang_like = Current.user.votes.where(vote_params).first_or_initialize
    if params[:is_liked] == 'true' || params[:is_unliked] == 'true'
      slang_like.destroy
      redirect_back fallback_location: root_path, notice: 'Vote Removed'
    elsif slang_like.id.nil? || slang_like.id
      slang_like.upvote = params[:is_liked] ? true : false
      slang_like.update(vote_params)
      redirect_back fallback_location: root_path, notice: 'Vote Added'
    else
      # Shouldn't be reaching here
      redirect_back fallback_location: root_path, notice: 'Vote Removed'
    end
  end

  private

  def slang_params
    params.require(:slang).permit(:word, :definition)
  end

  def vote_params
    params.require(:vote).permit(:slang_id, :value)
  end
end
