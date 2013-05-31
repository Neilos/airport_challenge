require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/airport'


describe Airport do
  before do
    @airport = Airport.new
    @small_capacity_airport = Airport.new(2)
    @plane1 = Plane.new
    @plane2 = Plane.new
    @plane3 = Plane.new
    @plane4 = Plane.new
    @plane5 = Plane.new
  end

  # test_plane_can_land  
  it "should be able to land a plane" do
    @airport.land_plane(@plane1)
    @plane1.landed?.must_equal true
  end

  # inserted test
  it "should know about landed planes" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.landed_planes.must_include @plane1
    @airport.landed_planes.must_include @plane2
  end

  # A plane currently in the airport can be requested to take off.
  # test_plane_can_take_off
  it "should be able to request planes to take off but only if they are in the airport" do
    def @airport.weather_state
      :sunny
    end
    @airport.land_plane(@plane1)
    @airport.instruct_take_off(@plane1)
    @plane1.landed?.must_equal false

    @plane2.land!
    @airport.instruct_take_off(@plane2)
    @plane2.landed?.must_equal true
  end

  # inserted test
  it "should know when it is full (of planes)" do
    @small_capacity_airport = Airport.new(2)
    def @small_capacity_airport.weather_state
      :sunny
    end

    @small_capacity_airport.land_plane(@plane1)
    @small_capacity_airport.land_plane(@plane2)
    @small_capacity_airport.full?.must_equal true
    @small_capacity_airport.instruct_take_off(@plane1)
    @small_capacity_airport.full?.must_equal false
  end

  # No more planes can be added to the airport, if it's full.
  # It is up to you how many planes can land in the airport and how that is impermented.
  # test_no_plane_can_land_if_airport_is_full
  it "should not land planes if airport is full" do
    @small_capacity_airport = Airport.new(2)

    @small_capacity_airport.land_plane(@plane1)
    @small_capacity_airport.land_plane(@plane2)

    lambda { @small_capacity_airport.land_plane(@plane3) }.must_raise(StandardError)

    @plane1.landed?.must_equal true
    @plane2.landed?.must_equal true
    @plane3.landed?.must_equal false

  end


  # If the airport is full then no planes can land
  #test_that_plane_can_land_after_airport_is_full_and_a_take_off_happened
  it "a full airport can land planes after a plane take off happens" do
    @small_capacity_airport = Airport.new(2)
    def @small_capacity_airport.weather_state
      :sunny
    end
    
    @small_capacity_airport.land_plane(@plane1)
    @small_capacity_airport.land_plane(@plane2)
    
    @small_capacity_airport.instruct_take_off(@plane1)

    @small_capacity_airport.land_plane(@plane3)

    @plane1.landed?.must_equal false
    @plane2.landed?.must_equal true
    @plane3.landed?.must_equal true

  end

  ############## TEST MOVED TO plane_test.rb ################
  # When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
  # test_plane_has_a_flying_status_after_it_is_created
  ###########################################################



  # When we land a plane at the airport, the plane in question should have its status changed to "landed"
  # test_plane_has_a_landed_status_after_landing
  it "should change the status of a plane to 'landed' when landing a plane" do
    @airport.land_plane(@plane1)
    @plane1.status.must_equal :landed
  end


  # When the plane takes of from the airport, the plane's status should become "flying"
  # test_plane_has_a_flying_status_after_take_off
  it "should change status of a plane to 'flying' after instructing plane to take off" do
    def @airport.weather_state
      :sunny
    end
    @airport.land_plane(@plane1)
    @airport.instruct_take_off(@plane1)
    @plane1.status.must_equal :flying
  end

  # include a weather condition using a module
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.

  # This will require stubbing to stop the random return of the weather.
  # test_that_no_plane_can_take_off_with_a_storm_brewing
  it "should not allow planes to take off with a storm brewing" do
    def @airport.weather_state
      :stormy
    end
    @airport.land_plane(@plane1)
    @airport.instruct_take_off(@plane1)
    @plane1.status.wont_equal :flying
  end

  # As with the above test, if the airport has a weather condition of stormy,
  # the plane can not land, and must not be in the airport
  # test_that_no_plane_can_land_when_there_is_a_storm_brewing
  it " test_that_no_plane_can_land_when_there_is_a_storm_brewing" do
  end

  # grand final
  # Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
  # Be careful of the weather, it could be stormy!
  # Check when all the planes have landed that they have the right status "landed"
  # Once all the planes are in the air again, check that they have the status of flying!
  #test_all_planes_can_land_then_all_planes_in_airport_can_takeoff
  it "test_all_planes_can_land_then_all_planes_in_airport_can_takeoff" do
  end

end