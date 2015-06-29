class Admin::UsersController < ApplicationController
  before_action :logged_in_admin

  def index
    @users = User.normal.paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if User.find(params[:id]).destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.can_not_delete"
    end
    redirect_to admin_users_url
  end

end
