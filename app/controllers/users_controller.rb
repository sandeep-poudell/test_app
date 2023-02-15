class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.valid?
      @user.save
      flash[:notice] = "User was created successfully"
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

end

