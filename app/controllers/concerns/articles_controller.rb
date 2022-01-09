class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    # binding.break
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      # flash msg when success
      flash[:notice] = 'Article was created successfully'
      # redirect_to article_path(@article)  or
      redirect_to @article
    else
      #   binding.break
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(params.require(:article).permit(:title, :description))
    # binding.break
    if @article.save
      # flash msg when success
      flash[:notice] = 'Article was updated successfully'
      # redirect_to article_path(@article) or
      redirect_to @article
    else
      #   binding.break
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
end
