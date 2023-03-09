class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :destroy, :update]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :destroy, :update]

    def show
        # @article = Article.find(params[:id])        
    end

    def index
      @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
      @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user  = current_user 
        if res = @article.save
          flash[:notice] = "Article was created successfully!!"
          redirect_to @article  
        else
          render "new"
        end

    end

    def edit
      # @article = Article.find(params[:id])
    end

    def update
      # @article = Article.find(params[:id])
      @article.update(article_params)
      if @article.save
        flash[:notice] = "Article has been updated!!"
        redirect_to @article
      else
        render "edit"
      end

    end

    def destroy
      # @article  = Article.find(params[:id])
      # get_article_by_id(params[:id])
      @article.destroy
      redirect_to articles_path
    end

    private 
    def set_article()
      @article = Article.find(params[:id])    
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user
        flash[:alert] = "You can only edit your articles!"
        redirect_to article_path(@article)
      end
    end

end