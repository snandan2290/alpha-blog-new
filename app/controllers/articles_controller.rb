class ArticlesController < ApplicationController

    def show
        # byebug
        @article = Article.find(params[:id])        
    end

    def index
        @articles =Article.all
    end

    def new

    end

    def create
        # render plain: params[:article]
        @article = Article.new(params.require(:article).permit(:title, :description))
        res = @article.save
        @articles = Article.all
        # render plain: @articles.inspect
        # render plain: @article.inspect
        redirect_to  @article
    end

end