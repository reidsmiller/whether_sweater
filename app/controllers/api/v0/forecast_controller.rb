class Api::V0::ForecastController < ApplicationController
  def show
    forecast = ForecastFacade.new(params[:location]).forecast
    render json: ForecastSerializer.new(forecast)
  rescue ForecastFacade::GeolocationError => e
    render json: { errors: { detail: e.message } }, status: :bad_request
  end
end