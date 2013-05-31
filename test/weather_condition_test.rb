require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/weather_condition'

class WeatherConditionInstance

include WeatherCondition


end

describe WeatherCondition do

  before do
    @weather_condition = WeatherConditionInstance.new
  end

  it "should have a weather_state" do
    @weather_condition.must_respond_to :weather_state
  end

  it "should have either a 'stormy' or 'sunny' weather_state" do
    [:stormy, :sunny].must_include @weather_condition.weather_state
    [:stormy, :sunny].wont_include :cloudy
  end

end