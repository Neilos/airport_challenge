require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/plane'

describe Plane do
  before do
    @plane = Plane.new
  end
  
  it "should be able to land" do
    @plane.must_respond_to :land!
  end

  it "should be able to fly" do
    @plane.must_respond_to :take_off!
  end

  it "should know whether it is landed" do
    @plane.must_respond_to :landed?
  end
  
  # When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
  # test_plane_has_a_status_after_it_is_created
  it "should have a 'flying' status after it is created" do
    puts "#{@plane.status}"
    @plane.status.must_equal :flying
  end 

  it "should not be landed when flying" do
    @plane.landed?.must_equal false
  end

  it "should know whether it has landed" do
    @plane.landed?.must_equal false
    @plane.land!
    @plane.landed?.must_equal true
  end

  it "should be flying when flying" do
    @plane.take_off!
    @plane.flying?.must_equal true
  end

end
