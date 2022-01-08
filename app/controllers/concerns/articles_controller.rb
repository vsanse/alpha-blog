class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    # binding.break
    @article = Article.find(params[:id])
  end

  def new; end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    @article.save
    # redirect_to article_path(@article)  or
    redirect_to @article
  end
end
