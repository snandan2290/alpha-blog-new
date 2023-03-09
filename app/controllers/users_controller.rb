class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, :require_same_user, only: [:edit, :update, :destroy]
    

    def show
        get_user_article
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Alpha-blog #{@user.username}, you have successfully signup"
            redirect_to  user_path(@user)
        else
            render 'new'
        end
    end

    def edit
        puts "@users::#{@user}"
    end

    def update
      @user.update(user_params)
      if @user.save
        flash[:notice] = "Profile has been updated!!"
        redirect_to user_path
      else
        render "edit"
      end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "User profile and associated articles deleted!"
        redirect_to articles_path
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

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can only edit your profile!!"
            redirect_to user_path(@user)
        end
    end

end