module WorkdayTime
  START_OF_DAY = '9:00'

  class << self
    def time_string_to_numeric(time_string)
      raise "Not a valid time string" unless time_string.include?(':')
      hours = time_string.split(':')[0].to_i
      minutes = time_string.split(':')[1].to_f / 60
      hours + minutes
    end

    def numeric_time_to_time_string(numeric_time)
      hours = numeric_time.floor
      minutes = (numeric_time.modulo(1) * 60).to_i
      formatted_minutes = minutes < 10 ? "0#{minutes}" : minutes
      "#{hours}:#{formatted_minutes}"
    end

    def add_time_length_to_start_time(time_length, start_time = START_OF_DAY)
      raise "time_length should be a number" unless time_length.is_a? Numeric
      end_time = time_string_to_numeric(start_time) + time_length
      numeric_time_to_time_string(end_time)
    end

    def military_to_12_hour(time_string)
      raise "Not a valid time string" unless time_string.include?(':')

      hours, minutes = time_string.split(':')
      formatted_hours = hours.to_i > 12 ? hours.to_i - 12 : hours
      "#{formatted_hours}:#{minutes}"
    end
  end
end


# p WorkdayTime.add_time_length_to_start_time(1.5, '10:00')
