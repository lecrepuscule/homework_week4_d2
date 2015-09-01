require_relative "spec_helper"

describe Van do

  def dock_various_bikes (station, broken_num, working_num)
    broken_num.times do
      broken_bike = Bike.new
      broken_bike.break
      station.dock(broken_bike)
    end
    working_num.times {station.dock(Bike.new)}
  end

  let(:van) {Van.new(capacity: 10)}
  let(:bike) {Bike.new}
  let(:station) {DockingStation.new(capacity: 20)}

  it "should be created with no bikes on it" do
    expect(van.bike_count).to eq 0
  end

  it "should be able to load up broken bikes at a station" do
    dock_various_bikes(station,8,10)
    puts van.load_broken_bikes(station).inspect
    expect(van.bike_count).to eq 8
  end

  it "should take away the broken bikes at a station" do
    dock_various_bikes(station,8,10)
    van.load_broken_bikes(station)
    expect(station.bike_count).to eq 10
  end

  it "should know when the van reaches capacity" do
    dock_various_bikes(station,10,10)
    van.load_broken_bikes(station)
    expect(van.full?).to be true
  end

  it "should stop loading bikes when reaches capacity" do
    dock_various_bikes(station,11,9)
    expect{van.load_broken_bikes(station)}.to raise_error "Van is full"
  end

end