class Api::V1::FollowsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if current_user
      @community = Community.find(params[:community_id])
      current_user.follow(@community)
      render json: {"info" => "success"}
    else
      render json: {"info" => "Not logged In"}
    end
  end
end
