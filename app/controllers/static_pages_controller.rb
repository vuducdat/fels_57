class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.following_activities.paginate page: params[:page],
                                                               per_page: Settings.per_page
      respond_to :html, :js
    end
  end
end
