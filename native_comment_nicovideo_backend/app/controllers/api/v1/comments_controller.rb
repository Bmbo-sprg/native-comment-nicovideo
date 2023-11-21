class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  # GET /comments
  def index
    if params[:timestamp]
      @comments = Comment.where("created_at > ?", params[:timestamp].to_datetime).order(created_at: :desc)
    else
      @comments = Comment.order(created_at: :desc)
    end
    render json: @comments, status: :ok
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/:id
  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  # DELETE /comments
  def destroy_multiple
    if params[:timestamp]
      Comment.where("created_at > ?", params[:timestamp].to_datetime).destroy_all
    else
      Comment.destroy_all
    end
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :comment_id, :content, :status)
  end
end
