class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.remember ? remember(user) : forget(user) 
      redirect_to user.role == Settings.admin ? admin_users_url : root_url
    else
      flash.now[:danger] = t "danger.errorMail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
