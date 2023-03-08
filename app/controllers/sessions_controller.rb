class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email])
    puts "@user::#{@user}"
    if @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "User logged in successfully!!"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Invalid Email address or Password!!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "User logged out successfully!!"
    redirect_to root_path
  end
  
end
