class Admin::WordsController < ApplicationController

  before_action :logged_in_admin
  before_action :set_category, except: :destroy
  before_action :set_word, only: [:show, :edit, :update]

  def index
    @words = @category.words.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @answers = @word.answers
  end

  def new
    @word = @category.words.build
    4.times {@word.answers.build}
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "flash.add_word_ok"
      redirect_to admin_category_url @category
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "flash.editted_word"
      redirect_to admin_category_word_url
    else
      render :edit
    end
  end

  def destroy
    if Word.find(params[:id]).destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.can_not_delete"
    end
    redirect_to admin_category_words_url
  end

  private
  def word_params
    params.require(:word).permit :content, answers_attributes: [:id, :content, :is_correct]
  end

  def set_category
    @category = Category.find params[:category_id]
  end

  def set_word
    @word = Word.find params[:id]
  end

end
