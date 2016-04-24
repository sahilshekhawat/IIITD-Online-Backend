class Api::V1::CommentsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if current_user
      @comment = @commentable.comments.new do |comment|
        comment.comment = params[:comment_text]
        comment.user = current_user
      end
      @comment.save
      render json: {"info" => "success"}
    else
      render json: {"info" => "Not logged In"}
    end
  end

end
