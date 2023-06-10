class City
  attr_reader :id, :name, :state
  attr_accessor :latitude, :longitude

  def initialize(params)
    @id = nil
    @name = params[:city]
    @state = params[:state]
    @latitude = nil
    @longitude = nil
  end
end