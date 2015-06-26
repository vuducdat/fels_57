class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find params[:id]
    if !params[:type].blank? && Settings.naming_for_action_follow.include?(params[:type])
      @title = params[:type]
      @users = @user.send(params[:type]).paginate page: params[:page],
                                                  per_page: Settings.per_page
    end
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "flash.not_loggin"
      redirect_to login_url
    end
  end  
end
