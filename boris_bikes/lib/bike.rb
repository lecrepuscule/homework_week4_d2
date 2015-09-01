class Bike

  attr_writer :broken

  def initialize
    @broken = false
  end

  def broken?
    @broken
  end

  def break
    @broken = true
  end
  
end