class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.add_category_ok"
      redirect_to admin_categories_url
    else
      reder :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
