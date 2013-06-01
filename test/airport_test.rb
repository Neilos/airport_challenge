require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/airport'


describe Airport do
  before do
    @airport = Airport.new
    def @airport.current_weather_conditions; :sunny; end
    @big_airport = Airport.new(capacity: 6)
    @planes = [
      @plane1 = Plane.new,
      @plane2 = Plane.new,
      @plane3 = Plane.new,
      @plane4 = Plane.new,
      @plane5 = Plane.new,
      @plane6 = Plane.new
    ]
  end

  #debug helper method
  def airport_status(airport)
    puts "Airport capacity is: #{airport.capacity}"
    puts "Planes in airport are: #{airport.landed_planes}"
    puts "Airport landed_planes_count is: #{airport.landed_planes_count}"
    puts "Is airport full? #{airport.full?}"
    puts "Airport current_weather_conditions are: #{airport.current_weather_conditions}"
  end

  #debug helper method
  def plane_status(plane, identifier=plane.object_id)
    puts "Plane#{identifier} is currently: #{plane.status}"
  end

  # test_plane_can_land  
  it "should be able to land a plane and in so doing change it's status" do
    @airport.land_plane(@plane1)
    @plane1.status.must_equal Plane::LANDED
  end

  # ADDITIONAL TEST
  it "should be able to instruct a plane to take off and in so doing change it's status" do
    @airport.instruct_take_off(@plane1)
    @plane1.status.must_equal Plane::FLYING
  end

  # ADDITIONAL TEST
  it "should return a count of of planes that are currently in the airport" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.landed_planes_count.must_equal 2
  end

  # ADDTIONAL TEST
  it "should return a list of planes in the airport" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.landed_planes.must_be_kind_of Enumerable
    @airport.landed_planes.must_include @plane1
    @airport.landed_planes.must_include @plane2
  end

  # ADDTIONAL TEST
  it "should not accept landed planes without landing them first" do
    @airport.landed_planes << @plane1
    @airport.landed_planes_count.must_equal 0
  end

  # ADDTIONAL TEST
  it "should know about landed planes" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.landed_planes.must_include @plane1
    @airport.landed_planes.must_include @plane2
  end

  # ADDITIONAL TEST
  it "should know when it is full (of planes)" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.full?.must_equal true
    @airport.instruct_take_off(@plane1)
    @airport.full?.must_equal false
  end

  # A plane currently in the airport can be requested to take off.
  # test_plane_can_take_off
  it "should be able to instruct planes to take off only if they are in the airport" do
    @airport.land_plane(@plane1)
    @airport.instruct_take_off(@plane1)
    @plane1.status.must_equal Plane::FLYING
    @plane2.land!
    @airport.instruct_take_off(@plane2)
    @plane2.status.must_equal Plane::LANDED
  end

  # No more planes can be added to the airport, if it's full.
  # It is up to you how many planes can land in the airport and how that is impermented.
  # test_no_plane_can_land_if_airport_is_full
  it "should not land planes if airport is full" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)

    lambda { @airport.land_plane(@plane3) }.must_raise(StandardError)

    @plane1.status.must_equal Plane::LANDED
    @plane2.status.must_equal Plane::LANDED
    @plane3.status.must_equal Plane::FLYING
  end


  # If the airport is full then no planes can land
  #test_that_plane_can_land_after_airport_is_full_and_a_take_off_happened
  it "a full airport can land planes after a plane take off happens" do
    @airport.land_plane(@plane1)
    @airport.land_plane(@plane2)
    @airport.instruct_take_off(@plane1)
    @airport.land_plane(@plane3)

    @plane1.status.must_equal Plane::FLYING
    @plane2.status.must_equal Plane::LANDED
    @plane3.status.must_equal Plane::LANDED
  end

  ############## TEST MOVED TO plane_test.rb ################
  # When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
  # test_plane_has_a_flying_status_after_it_is_created
  ###########################################################



  # When we land a plane at the airport, the plane in question should have its status changed to "landed"
  # test_plane_has_a_landed_status_after_landing
  it "should change the status of a plane to 'landed' when landing a plane" do
    @airport.land_plane(@plane1)
    @plane1.status.must_equal Plane::LANDED
  end


  # When the plane takes of from the airport, the plane's status should become "flying"
  # test_plane_has_a_flying_status_after_take_off
  it "should change status of a plane to 'flying' after instructing plane to take off" do
    @airport.land_plane(@plane1)
    @airport.instruct_take_off(@plane1)
    @plane1.status.must_equal Plane::FLYING
  end

  # include a weather condition using a module
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
  it "should be weather aware" do
    @airport.must_be_kind_of WeatherAware
  end

  it "should know about the weather" do
    @airport.must_respond_to :current_weather_conditions
  end

  # This will require stubbing to stop the random return of the weather.
  # test_that_no_plane_can_take_off_with_a_storm_brewing
  it "should not allow planes to take off with a storm brewing" do
    @airport.land_plane(@plane1)
    def @airport.current_weather_conditions; :stormy; end
    @airport.instruct_take_off(@plane1)
    @airport.landed_planes.must_include @plane1
  end

  # As with the above test, if the airport has a weather condition of stormy,
  # the plane can not land, and must not be in the airport
  # test_that_no_plane_can_land_when_there_is_a_storm_brewing
  it "should not allow planes to land if a storm is brewing" do
    def @airport.current_weather_conditions; :stormy; end
    @airport.land_plane(@plane1)
    @airport.landed_planes.wont_include @plane1
  end

  # grand final
  # Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
  # Be careful of the weather, it could be stormy!
  # Check when all the planes have landed that they have the right status "landed"
  # Once all the planes are in the air again, check that they have the status of flying!
  #test_all_planes_can_land_then_all_planes_in_airport_can_takeoff
  it "should be able to land planes until full and then instruct all planes to takeoff" do
    until @big_airport.full?
      @planes.each do |plane|
        unless plane.landed?
          # puts
          # puts "before attempting to land...."
          # plane_status(plane)
          @big_airport.land_plane(plane) unless (@big_airport.full? || @big_airport.current_weather_conditions == :stormy)          
          # puts "after attempting to land...."
          # plane_status(plane)
          # airport_status(@big_airport)
        end
      end
    end
    
    @big_airport.landed_planes.each do |plane|
      plane.status.must_equal Plane::LANDED
    end

    until @big_airport.landed_planes.count ==0
      @big_airport.instruct_take_off(@big_airport.landed_planes[-1]) unless (@big_airport.current_weather_conditions == :stormy)
    end

    @planes.each do |plane|
      plane.status.must_equal Plane::FLYING
      plane.status.wont_equal Plane::LANDED
    end

  end

end