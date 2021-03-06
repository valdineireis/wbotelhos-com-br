# coding: utf-8

class CommentsController < ApplicationController
  before_filter :require_login, only: [:update]

  def create
    @article = Article.includes(:user).find params[:article_id]
    @comment = @article.comments.new sanitize_comment
    @comment.author = is_logged?
    @comment.comment = Comment.find params[:comment_id] unless params[:comment_id].nil?

    if @comment.save
      send_mail
    else
      flash[:alert] = get_errors
    end

    # TODO: how to keep the value of filled fields on dispatcher?
    redirect_to article_url(@article.year, @article.month, @article.day, @article.slug, anchor: 'comment-form')
  end

  def update
    @article = Article.find params[:article_id]

    @comment = @article.comments.find params[:id]

    if @comment.update_attributes params[:comment]
      flash[:notice] = t('flash.comments.update.notice')
    else
      flash[:alert] = t('flash.comments.update.alert')
    end

    redirect_to article_url(@article.year, @article.month, @article.day, @article.slug)
  end

  private

  def get_errors
    error = ''

    @comment.errors.messages.each do |message|
      error += message[1][0] + "<br />"
    end

    error.html_safe
  end

  def sanitize_comment(comment = params[:comment])
    comment[:name]  = nil if comment[:name]   == t('activerecord.attributes.comment.name')
    comment[:email] = nil if comment[:email]  == t('activerecord.attributes.comment.email')
    comment[:url]   = nil if comment[:url]    == t('activerecord.attributes.comment.url')
    comment[:body]  = nil if comment[:body] && comment[:body].include?('Seu comentário *')
    comment
  end

  def send_mail
    begin
       CommentMailer.new(@article, @comment, logger).send
       flash[:notice] = t('flash.comments.create.notice')
    rescue Exception => e
      logger.error "Was not possible to send mail: #{e}"
      flash[:notice] = t('comment.email.not_sent')
     end
  end
end
