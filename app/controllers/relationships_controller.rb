class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find params[:user_id]
    if !params[:type].blank? && Settings.naming_for_action_follow.include?
      (params[:type])
      @title = params[:type]
      @users = @user.send(params[:type]).paginate page: params[:page]
    end
  end

  def create
    user = User.find params[:followed_id]
    current_user.follow user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    user = Relationship.find params[:id].followed
    current_user.unfollow user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end