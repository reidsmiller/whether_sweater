class Api::V0::RoadTripController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_unauthorized_response

  def create
    User.find_by!(api_key: params[:api_key])
    forecast = ForecastFacade.new(params[:destination]).weather_data
    road_trip = RoadTripFacade.new(params, forecast).road_trip
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def render_unauthorized_response
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end