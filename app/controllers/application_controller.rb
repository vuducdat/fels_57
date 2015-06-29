class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

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
