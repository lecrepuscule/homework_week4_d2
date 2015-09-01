require_relative "spec_helper"

describe Van do
  let(:van) {Van.new}
  let(:bike) {Bike.new}
  let(:station) {DockingStation.new(capacity: 20)}

  it "should be created with no bikes on it" do
    expect(van.bike_count).to eq 0
  end

  it "should be able to load broken bikes at a station" do
    8.times {station.dock(Bike.new.break)}
    10.times {station.dock(Bike.new)}
    van.load_broken_bikes(station)
    expect(van.bike_count).to eq 8
  end

end