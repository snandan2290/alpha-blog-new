class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index

  end

  def show
    @category = Category.find(params[:id])
  end
  
  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:notice] = "Category created successfully!!"
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end