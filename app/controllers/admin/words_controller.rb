class Admin::WordsController < ApplicationController
  def index
    @words = Word.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.find params[:category_id]
    @word = @category.words.build
    4.times {@word.answers.build}
  end

  def create
    @category = Category.find params[:category_id]
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "flash.add_word_ok"
      redirect_to admin_category_url @category
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content, answers_attributes: [:content, :is_correct]
  end

end
