class RoadTripFacade
  def initialize(params, forecast_data)
    @origin = params[:origin]
    @destination = params[:destination]
    @forecast_data = forecast_data
  end

  def road_trip
    RoadTrip.new(road_trip_data, @forecast_data, @origin, @destination)
  end

  private

  def service
    @_service ||= MapquestService.new
  end

  def road_trip_data
    @_road_trip_data ||= service.road_trip(@origin, @destination)
  end
end