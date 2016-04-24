class Api::V1::CommunitiesController < ApplicationController

  def index
    filters = request.query_parameters
    render json: Community.fastapi.filter(filters).response
  end

  def show
    render json: Community.fastapi.fetch(params[:id]).response
  end

  def create
    @community = Community.new(community_params)
    @community.slug = @community.name.downcase.tr(" ", "-")
    @community.user_id = current_user.id
    @community.save
    render json: {"info" => "success"}
  end
end
