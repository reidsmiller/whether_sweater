class RoadTripFacade
  def initialize(params, forecast)
    @origin = params[:origin]
    @destination = params[:destination]
    @forecast = forecast
  end

  def road_trip
    RoadTrip.new(road_trip_data, forecast)
  end

  private

  def service
    @_service ||= MapquestService.new
  end

  def road_trip_data
    @_road_trip_data ||= service.road_trip(@origin, @destination)
  end
end