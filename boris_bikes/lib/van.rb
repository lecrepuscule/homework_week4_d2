require_relative "docking_station"
require_relative "bike"
require_relative "garage"

class Van

  DEFAULT_CAPACITY = 20

  def initialize(options={})
    @bikes = []
    @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def bike_count
    @bikes.count
  end

  def load_bikes source
    source.bikes_for_pickup.each do |bike| 
      raise "Van is full" if full?
      @bikes << bike
      source.release(bike)
    end
  end

  def unload_bikes destination
    if destination.is_a? DockingStation
      bikes_to_unload = @bikes.reject{|bike| bike.broken?}
    elsif destination.is_a? Garage
      bikes_to_unload = @bikes.select{|bike| bike.broken?}
    else
      raise "Unknown destination"
    end
    bikes_to_unload.each do |bike|
      destination.dock(bike)
      @bikes.delete(bike)
    end
  end

  def full?
    bike_count >= @capacity
  end

end