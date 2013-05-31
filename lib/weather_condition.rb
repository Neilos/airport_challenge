
module WeatherCondition


def weather_state
  randomizer = Random.new
  case randomizer.rand(0..100)
  when 60..100
    @weather_state = :stormy
  else 
    @weather_state = :sunny
  end
  @weather_state
end

end