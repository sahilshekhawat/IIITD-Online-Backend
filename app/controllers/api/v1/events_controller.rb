class Api::V1::EventsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    filters = request.query_parameters
    render json: Events.fastapi.filter(filters).response
  end

  def show
    render json: Events.fastapi.fetch(params[:id]).response
  end

  def create
    if current_user
      @event = current_user.events.new(event_params)
      if @event.save
        render json: {"info" => "success"}
      else
        render json: {"info" => "error"}
      end
    else
      render json: {"info" => "Not logged In"}
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :when)
  end
end
