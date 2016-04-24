class Api::V1::CommunitiesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    filters = request.query_parameters
    render json: Community.fastapi.filter(filters).response
  end

  def show
    render json: Community.fastapi.fetch(params[:id]).response
  end

  def create
    if current_user
      @community = Community.new(community_params)
      @community.slug = @community.name.downcase.tr(" ", "-")
      @community.user_id = current_user.id
      @community.save
      render json: {"info" => "success"}
    else
      render json: {"info" => "Not logged In"}
    end
  end

  private
  def community_params
    params.require(:community).permit(:name, :about, :avatar, :cover)
  end
end
