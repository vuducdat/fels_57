class Admin::CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @words = @category.words
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

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.editted_category"
      redirect_to admin_category_url
    else
      render :edit
    end
  end

  def destroy
    if Category.find(params[:id]).destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.can_not_delete"
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def set_category
    @category = Category.find params[:id]
  end
end
