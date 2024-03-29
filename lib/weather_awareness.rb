require_relative 'weather'

module WeatherAware

  def change_climate(weather)
    @weather = weather
  end
  
  def weather
    @weather ||= Weather.new
  end
  private :weather

  def current_weather_conditions
    weather.generate_conditions
  end

end