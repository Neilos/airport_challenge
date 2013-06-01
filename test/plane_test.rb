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

  it "should have a publically readable status" do
    @plane.must_respond_to :status
  end
  
  it "should have a 'landed' status after it has landed" do
    @plane.land!
    @plane.status.must_equal Plane::LANDED
  end

  it "should have a flying status after take-off" do
    @plane.land!
    @plane.take_off!
    @plane.status.must_equal Plane::FLYING
  end

  it "should have a 'flying' status after it is created" do
    new_plane = Plane.new
    new_plane.status.must_equal Plane::FLYING
  end 

  it "should know whether it has landed" do
    @plane.land!
    @plane.landed?.must_equal true
    @plane.take_off!
    @plane.landed?.wont_equal true
  end

end
