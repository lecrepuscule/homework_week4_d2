class Van

  def initialize
    @bikes = []
  end

  def bike_count
    @bikes.count
  end

  def load_broken_bikes station
    station.bikes.each{|bike| @bikes << bike if bike.broken?}
  end

end