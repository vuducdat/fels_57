class Admin::UsersController < ApplicationController
  before_action :logged_in_admin

  def index
    @users = User.normal.paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if User.find(params[:id]).destroy
      flash[:danger] = t "flash.can_not_delete"
    else
      flash[:success] = t "flash.deleted"
    end
    redirect_to admin_users_url
  end

  private
  def logged_in_admin
    unless logged_in?
      flash[:danger] = t "flash.not_loggin"
      redirect_to login_url
    end
    unless admin?
      flash[:danger] = t "flash.not_admin"
      redirect_to root_path
    end
  end
end
