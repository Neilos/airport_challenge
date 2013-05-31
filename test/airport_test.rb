require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/airport'


describe Airport do
  before do
    @airport = Airport.new
    @plane1 = Plane.new
    @plane2 = Plane.new
  end

  it "test_plane_can_land" do
    @airport.land_plane(@plane1)
    @plane1.landed?.must_equal true
  end

  it "airport knows about landed planes" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.landed_planes.must_include @plane1
    @airport.landed_planes.must_include @plane2
  end

  # A plane currently in the airport can be requested to take off.
  it "test_plane_can_take_off" do
    @airport.instruct_take_off(@plane1)
    @plane1.landed?
  end

  # No more planes can be added to the airport, if it's full.
  # It is up to you how many planes can land in the airport and how that is impermented.
  it " test_no_plane_can_land_if_airport_is_full" do
  end


  # If the airport is full then no planes can land
  it " test_that_plane_can_land_after_airport_is_full_and_a_take_off_happened" do
  end

  # When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
  it " test_plane_has_a_flying_status_after_it_is_created" do
  end 

  # When we land a plane at the airport, the plane in question should have its status changed to "landed"
  it " test_plane_has_a_landed_status_after_landing" do
  end


  # When the plane takes of from the airport, the plane's status should become "flying"
  it " test_plane_has_a_flying_status_after_take_off" do
  end

  # include a weather condition using a module
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.

  # This will require stubbing to stop the random return of the weather.
  it " test_that_no_plane_can_take_off_with_a_storm_brewing" do
  end

  # As with the above test, if the airport has a weather condition of stormy,
  # the plane can not land, and must not be in the airport
  it " test_that_no_plane_can_land_when_there_is_a_storm_brewing" do
  end

  # grand final
  # Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
  # Be careful of the weather, it could be stormy!
  # Check when all the planes have landed that they have the right status "landed"
  # Once all the planes are in the air again, check that they have the status of flying!
  it " test_all_planes_can_land_then_all_planes_in_airport_can_takeoff" do
  end

end