class Api::V1::PostsController < ApplicationController
  
  def index
    filters = request.query_parameters
    render json: Post.fastapi.filter(filters).response
  end

  def show
    render json: Post.fastapi.fetch(params[:id]).response
  end
end
