class Garage
  
  DEFAULT_CAPACITY = 30

  def initialize(options={})
    @bikes = []
    @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def bike_count
    @bikes.count
  end

  def accept bike
    raise "Garage is full" if full?
    @bikes << bike
  end

  def fix bike
    bike.broken = false
  end

  def full?
    bike_count >= @capacity
  end
end