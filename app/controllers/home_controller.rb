class HomeController < ApplicationController
  def index
    @pagy, @slangs = pagy(Slang.where(is_approved: true).order(created_at: :desc))
    return unless Current.user

    @vote = Current.user.votes.new
  end
end
