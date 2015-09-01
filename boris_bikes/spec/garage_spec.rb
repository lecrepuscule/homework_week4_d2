require_relative "spec_helper"

describe Garage do

  let(:garage) {Garage.new}
  let(:bike) {Bike.new}

  it "should be created with no bikes" do
    expect(garage.bike_count).to eq 0
  end

  it "should be able to accept a bike" do
    garage.accept(bike)
    expect(garage.bike_count).to eq 1
  end

  it "should be able to fix a bike" do
    bike.break
    garage.fix(bike)
    expect(bike.broken?).to be false
  end

  it "should know when capacity is reached" do
    30.times {garage.accept(Bike.new)}
    expect(garage.full?).to be true
  end

  it "should not accept bikes when capacity is reached" do
    30.times {garage.accept(Bike.new)}
    expect{garage.accept(bike)}.to raise_error "Garage is full"
  end

  it "should be able to list out all fixed bikes" do
    working_bike, broken_bike = Bike.new, Bike.new
    broken_bike.break
    garage.accept(working_bike)
    garage.accept(broken_bike)
    puts garage.fixed_bikes.inspect
    expect(garage.fixed_bikes).to eq [working_bike]
  end

  it "should be able to release a bike" do
    garage.accept(bike)
    garage.release(bike)
    expect(garage.bike_count).to eq 0
  end

end