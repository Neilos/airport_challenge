class Weather

  attr_reader :probabilities, :weather_options
  private :weather_options

  def initialize(probalities={stormy: 0.4, sunny: 0.6})
    set_probabilities(probalities)
  end

  def set_probabilities(probalities)
    raise StandardError, "probalities must add up to 1" if not valid_probabilities?(probalities)
    set_weather_options probalities
    @probabilities = probalities 
  end

  def generate_conditions
    @randomizer ||= Random.new
    weather_decider = @randomizer.rand(0.0..1.0)
    case weather_decider
    when weather_options[:stormy] then :stormy
    when weather_options[:sunny] then :sunny
    else :freak
    end
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
