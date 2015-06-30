class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.following_activities.paginate page: params[:page],
                                                               per_page: Settings.per_page
    end
  end
end
