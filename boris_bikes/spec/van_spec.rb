require_relative "spec_helper"

describe Van do

  def dock_various_bikes (source, broken_num, working_num)
    broken_num.times do
      broken_bike = Bike.new
      broken_bike.break
      source.dock(broken_bike)
    end
    working_num.times {source.dock(Bike.new)}
  end

  def take_bikes_from (source, broken_num, working_num)
    dock_various_bikes(source, broken_num, working_num)
    van.load_bikes(source)
  end

  let(:van) {Van.new(capacity: 10)}
  let(:bike) {Bike.new}
  let(:station) {DockingStation.new(capacity: 20)}
  let(:garage) {Garage.new}

  it "should be created with no bikes on it" do
    expect(van.bike_count).to eq 0
  end

  it "should be able to load up broken bikes at a station" do
    take_bikes_from(station, 8, 10)
    expect(van.bike_count).to eq 8
  end

  it "should take away the broken bikes at a station" do
    take_bikes_from(station, 9, 11)
    expect(station.bike_count).to eq 11
  end

  it "should know when the van reaches capacity" do
    take_bikes_from(station, 10, 10)
    expect(van.full?).to be true
  end

  it "should stop loading bikes when reaches capacity" do
    dock_various_bikes(station, 11, 8)
    expect{van.load_bikes(station)}.to raise_error "Van is full"
  end

  it "should be able to unload broken bikes at a garage" do
    take_bikes_from(station, 6, 8)
    van.unload_bikes(garage)
    expect(van.bike_count).to eq 0
  end

  it "should be able to put broken bikes into a garage" do
    take_bikes_from(station, 2, 5)
    van.unload_bikes(garage)
    expect(garage.bike_count).to eq 2
  end

  it "should be able to load working bikes at a garage" do 
    take_bikes_from(garage, 10, 5)
    expect(van.bike_count).to eq 5
  end 

  it "should be able to take away working bikes from a garage" do 
    take_bikes_from(garage, 3, 10)
    expect(garage.bike_count).to eq 3
  end 

  it "should be able to unload working bikes at a station" do
    take_bikes_from(garage, 12, 7)
    van.unload_bikes(station)
    expect(van.bike_count).to eq 0
  end

  it "should be able to put working bikes into a station" do
    take_bikes_from(garage, 12, 7)
    van.unload_bikes(station)
    expect(station.bike_count).to eq 7
  end
end