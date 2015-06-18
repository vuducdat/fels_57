class FollowedController < ApplicationController
  before_action :logged_in_user, only: [ :index]

  def index
    @title = t("title.follower")
    @user = User.find params[:user_id]
    @users = @user.followers.paginate page: params[:page]
    render "users/show_follow"
  end

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "flash.not_loggin"
      redirect_to login_url
    end
  end
end
