require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/weather_awareness'

class WeatherAwareClass
  include WeatherAware
end

describe WeatherAwareClass do
  before do
    @weather_announcer = WeatherAwareClass.new
  end

  it "should be aware of current_weather_conditions" do
    @weather_announcer.must_respond_to :current_weather_conditions
  end

  it "should know current_weather_conditions when first initialized" do
    @weather_announcer.current_weather_conditions.wont_be_nil
  end

  it "should be able to change it's climate" do
    @weather_climate1 = Weather.new(stormy: 0.9, sunny: 0.1)
    @weather_announcer.change_climate(@weather_climate1)
    expected = {stormy: 0.9, sunny: 0.1}
    @weather_announcer.send(:weather).probabilities.must_equal expected

    @weather_climate2 = Weather.new(stormy: 0.2, sunny: 0.8)
    @weather_announcer.change_climate(@weather_climate2)
    expected = {stormy: 0.2, sunny: 0.8}
    @weather_announcer.send(:weather).probabilities.must_equal expected
  end

end