class Admin::DashboardsController < ApplicationController

  before_action :logged_in_admin

  def home
  end

end
