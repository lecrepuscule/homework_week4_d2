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

  def unload_broken_bikes garage
    @bikes.select{|bike| bike.broken?}.each do |bike|
      garage.accept(bike)
      @bikes.delete(bike)
    end
  end

  def unload_working_bikes docking_station
    @bikes.reject{|bike| bike.broken?}.each do |bike|
      docking_station.dock(bike)
      @bikes.delete(bike)
    end
  end

  def full?
    bike_count >= @capacity
  end


end