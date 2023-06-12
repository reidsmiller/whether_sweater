class Api::V0::RoadTripController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unauthorized_response

  def create
    User.find_by!(api_key: params[:api_key])
    road_trip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def render_unauthorized_response
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end