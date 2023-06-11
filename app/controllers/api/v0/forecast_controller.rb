class Api::V0::ForecastController < ApplicationController
  rescue_from ForecastFacade::GeolocationError, with: :render_bad_request_response

  def show
    forecast = ForecastFacade.new(params[:location]).forecast
    render json: ForecastSerializer.new(forecast)
  end

  private

  def render_bad_request_response(exception)
    render json: { errors: { detail: exception.message } }, status: :bad_request
  end
end