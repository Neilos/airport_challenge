class Weather

  attr_reader :weather_probabilities, :weather_options

  def initialize(probalities={stormy: 0.4, sunny: 0.6})
    set_weather_probabilities(probalities)
  end

  def set_weather_probabilities(probalities)
    raise StandardError, "probalities must add up to 1" if not valid_probabilities?(probalities)
    set_weather_options probalities
    @weather_probabilities = probalities 
  end

  private

  def set_weather_options(probalities_hash)
    sum = 0 
    @weather_options = Hash[ probalities_hash.to_a.map { |(prob, val)| [prob, sum...(sum += val)] } ]
  end

  def valid_probabilities?(probalities)
    probalities.values.inject(&:+) == 1
  end
  

end
