class Api::V1::UsersController < ApplicationController
  def index
    filters = request.query_parameters
    render json: User.fastapi.filter(filters).response
  end

  def getcurrentuser
    render json: User.fastapi.filter(:id => current_user.id).response
  end

  def show
    render json: User.fastapi.fetch(params[:id]).response
  end
end
