class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ForecastFacade::GeolocationError, with: :render_bad_request_response

  def render_unprocessable_entity_response(exception)
    render json: { errors: { detail: exception.message } }, status: :unprocessable_entity
  end

  def render_bad_request_response(exception)
    render json: { errors: { detail: exception.message } }, status: :bad_request
  end
end
