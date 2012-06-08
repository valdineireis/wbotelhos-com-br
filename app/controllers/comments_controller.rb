class CommentsController < ApplicationController

  before_filter :require_login, :only => [:update]

  def create
    article = Article.find(params[:article_id])

    comment = article.comments.new(params[:comment])
    comment.author = is_logged?
    comment.comment = Comment.find(params[:comment_id]) unless params[:comment_id].nil?

    mailer = CommentMailer.new(comment, article_path(article))

    if comment.save
      flash[:notice] = t("flash.comments.create.notice")
      mailer.send
    else
      flash[:alert] = t("flash.comments.create.alert")
    end

    redirect_to article_path(article, :anchor => "comments")
  end

  def update
    comment = Comment.find(params[:id])

    if comment.update_attributes(params[:comment])
      flash[:notice] = t("flash.comments.update.notice")
    else
      flash[:alert] = t("flash.comments.update.alert")
    end

    redirect_to article_path(params[:article_id])
  end

end
 