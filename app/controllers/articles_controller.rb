class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @articles = Article.order(created_at: :desc).all
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        @article.user = current_user
        if @article.valid?
            @article.save
            flash[:notice] = "Article was created successfully"
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article is updated successfully"
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @article.destroy
            flash[:alert] = "The article was deleted"
            redirect_to articles_path
        end
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end

end