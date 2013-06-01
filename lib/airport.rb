require_relative 'plane'
require_relative 'weather_awareness'

class Airport
include WeatherAware
attr_accessor :capacity, :landed_planes


def initialize(options={capacity: 2})
  @capacity = options[:capacity]
  @landed_planes = []
end

def land_plane(plane)
  raise(StandardError, "Airport is full.") if full?
  if current_weather_conditions == :sunny
    landed_planes.push plane if plane.land!
  end
end

def instruct_take_off(plane)
  if landed_planes.include?(plane) && (current_weather_conditions == :sunny)
    plane.take_off!
    landed_planes.delete plane
  end
end

def landed_planes_count
  landed_planes.count
end

def full?
  landed_planes_count == self.capacity
end

end