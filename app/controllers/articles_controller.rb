class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit index]
  before_action :require_same_user, only: %i[edit update destroy]
  def index
    @articles = Article.all
  end

  def show
    # binding.break
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      # flash msg when success
      flash[:notice] = 'Article was created successfully'
      # redirect_to article_path(@article)  or
      redirect_to @article
    else
      #   binding.break
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # binding.break
  end

  def update
    @article.update(article_params)
    # binding.break
    if @article.save
      # flash msg when success
      flash[:notice] = 'Article was updated successfully'
      # redirect_to article_path(@article) or
      redirect_to @article
    else
      #   binding.break
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = 'You can only edit or delete your own article'
      redirect_to @article
    end
  end
end
