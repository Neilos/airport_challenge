require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'
require '../lib/weather'


describe Weather do

  before do
    @weather = Weather.new
  end

  it "should be possible to set the weather probabilities" do
    @weather.must_respond_to :set_probabilities
  end

  it "should NOT be possible to set weather probabilities that don't add up to 1" do
    lambda { @weather.set_probabilities(stormy: 0.6, sunny: 0.6) }.must_raise StandardError
    lambda { @weather.set_probabilities(stormy: 0.6, sunny: 0.2) }.must_raise StandardError
    @weather.set_probabilities(stormy: 0.6, sunny: 0.4)
  end

  it "should be possible to check the weather probabilities" do
    @weather.set_probabilities(stormy: 0.8, sunny: 0.2)
    expected = {:stormy=>0.8, :sunny=>0.2}
    @weather.probabilities.must_equal expected
  end

  it "should have default weather_probabilities when initialized" do
    expected = {:stormy=>0.4, :sunny=>0.6}
    @weather.probabilities.must_equal expected
  end

  it "should have private weather options after the weather_probabilities have been set" do
    probabilities = @weather.set_probabilities(stormy: 0.8, sunny: 0.2)
    expected = {stormy: 0...0.8, sunny: 0.8...1.0}
    @weather.send(:weather_options).must_equal expected
  end

  it "should generate weather conditions that are either 'stormy' or 'sunny'" do
    [:stormy, :sunny].must_include @weather.generate_conditions
  end

end

