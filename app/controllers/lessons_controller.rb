class LessonsController < ApplicationController

  def create
    @category = Category.find params[:category_id]
    @lesson = Lesson.new
    @lesson.category = @category
    @lesson.user = current_user
    if @lesson.save
      flash[:success] = t "flash.success"
    else
      flash[:danger] = t "flash.fail"
    end
    redirect_to edit_category_lesson_path(@category, @lesson)
  end

  def edit
    @lesson = Lesson.find params[:id]
  end

end
