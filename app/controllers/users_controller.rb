class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :destroy, :update, :index]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :set_user, :get_user_article , only: [:show]

    def show
        
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        # byebug
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome to the Alpha-blog #{@user.username}, you have successfully signup"
            redirect_to  articles_path
        else
            render 'new'
        end
    end

    def edit
        set_user
        # @user = User.find(params[:id])
        puts "@users::#{@user}"
    end

    def update
        set_user
      @user.update(user_params)
      if @user.save
        flash[:notice] = "Profile has been updated!!"
        redirect_to user_path
      else
        render "edit"
      end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

    def get_user_article
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

end