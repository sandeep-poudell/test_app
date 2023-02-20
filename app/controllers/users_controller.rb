class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:notice] = "Your account information is successfully updated"
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed up !"
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:alert] = "Account is deleted along with its all associated articles"
    redirect_to articles_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user !=  @user
      flash[:alert] = "You can only edit your own profile"
      redirect_to @user
    end
  end

end

