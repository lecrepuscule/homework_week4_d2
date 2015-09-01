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

  def load_broken_bikes station
    station.broken_bikes.each do |bike| 
      raise "Van is full" if full?
      @bikes << bike
      station.release(bike)
    end
  end

  def unload_broken_bikes garage
    @bikes.select{|bike| bike.broken?}.each do |bike|
      garage.accept(bike)
      @bikes.delete(bike)
    end
  end

  def full?
    bike_count >= @capacity
  end


end