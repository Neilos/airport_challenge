require_relative 'plane'
require_relative 'weather_condition'

class Airport
include WeatherCondition
attr_reader :landed_planes


def initialize(capacity=5)
  @landed_planes = Array.new
  @capacity = capacity
end

def land_plane(plane)
  raise(StandardError, "Airport is full.") if full?
  landed_planes.push plane if plane.land!
end

def instruct_take_off(plane)
  if (landed_planes.include? plane) && (weather_state == :sunny)
    plane.take_off! 
    landed_planes.delete plane
  end
end

def full?
  landed_planes.count == @capacity
end



end