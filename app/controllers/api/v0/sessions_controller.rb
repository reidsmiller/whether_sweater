class Api::V0::SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    user = User.find_by!(email: params[:email])
    raise ActiveRecord::RecordNotFound unless user.authenticate(params[:password])

    render json: UserSerializer.new(user), status: :ok
  end

  private

  def render_not_found_response
    render json: { errors: { detail: 'Invalid credentials' } }, status: :unauthorized
  end
end
