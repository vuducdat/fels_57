class WordsController < ApplicationController
  def index
    @category = Category.find params[:category_id]

    @filter_status = params[:filter_status] || Settings.type_category.all

    @words = Word.filter_word_list(current_user, @filter_status, @category.id)
      .paginate page: params[:page]

    @categories_list = Category.all.collect{|category|
      [category.name, category_words_path(category)]}
  end
end
