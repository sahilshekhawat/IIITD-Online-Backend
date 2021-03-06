class Api::V1::PostsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    filters = request.query_parameters
    render json: Post.fastapi.filter(filters).response
  end

  def show
    render json: Post.fastapi.fetch(params[:id]).response
  end

  def create
    if current_user
      @post = current_user.posts.new(post_params)
      if @post.save
        render json: {"info" => "success"}
      else
        render json: {"info" => "error"}
      end
    else
      render json: {"info" => "Not logged In"}
    end
  end

  private
  def post_params
    params.require(:post).permit(:content, :attachment, :community_id)
  end
end
