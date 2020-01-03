module WorkdayTime
  START_OF_DAY = '9:00'

  def self.time_string_to_numeric(time_string)
    raise "Not a valid time string" unless time_string.include?(':')
    hours = time_string.split(':')[0].to_i
    minutes = time_string.split(':')[1].to_i / 60
    hours + minutes
  end

  def self.numeric_time_to_time_string(numeric_time)
    hours = numeric_time.floor
    minutes = (numeric_time.modulo(1) * 60)
    formatted_minutes = minutes < 10 ? "0#{minutes}" : minutes
    "#{hours}:#{formatted_minutes}"
  end

  def self.add_time_length_to_start_time(time_length, start_time = START_OF_DAY)
    raise "time_length should be a number" unless time_length.is_a? Numeric

    end_time = time_string_to_numeric(start_time) + time_length
    numeric_time_to_time_string(end_time)
  end
end
