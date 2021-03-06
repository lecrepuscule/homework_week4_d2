class Garage
  
  DEFAULT_CAPACITY = 30

  def initialize(options={})
    @bikes = []
    @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  end

  def bike_count
    @bikes.count
  end

  def dock bike
    raise "Garage is full" if full?
    @bikes << bike
  end

  def fix bike
    bike.broken = false
  end

  def full?
    bike_count >= @capacity
  end

  def bikes_for_pickup
    @bikes.reject{|bike| bike.broken?}
  end

  def release bike
    @bikes.delete(bike)
  end
end