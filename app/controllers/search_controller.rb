class SearchController < ApplicationController
  def index; end

  def show
    @pagy, @slangs = pagy(Slang.search(params[:q]))
    return unless Current.user

    @vote = Current.user.votes.new
  end
end