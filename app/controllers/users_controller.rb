class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: :show

  def index
    @users = User.paginate page: params[:page],
                           per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "title.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "title.update_profile_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "flash.not_loggin"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end

  def set_user
    @user = User.find params[:id]
  end
end
