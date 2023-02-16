class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:notice] = "Your account information is successfully updated"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.valid?
      @user.save
      flash[:notice] = "User was created successfully"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

end

