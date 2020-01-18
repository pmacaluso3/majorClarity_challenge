require_relative 'workday_time'

class Scheduler
  TRAVEL_DURATION = 0.5 #hours

  attr_reader :meetings, :time_module
  attr_accessor :schedule

  def initialize(meetings, time_module = WorkdayTime)
    @meetings = meetings
    @time_module = time_module
    @schedule = []
  end

  def meetings_of_type(type)
    meetings.select { |m| m[:type].to_sym == type.to_sym }
  end

  def onsite_meetings
    meetings_of_type(:onsite)
  end

  def offsite_meetings
    meetings_of_type(:offsite)
  end

  def current_end_of_schedule
    schedule.last ? schedule.last[:end_time] : time_module::START_OF_DAY
  end

  def schedule_entry_for_meeting(meeting, start_of_meeting = current_end_of_schedule)
    end_of_meeting = time_module.add_time_length_to_start_time(meeting[:duration], start_of_meeting)
    {
      name: meeting[:name],
      type: meeting[:type],
      start_time: start_of_meeting,
      end_time: end_of_meeting
    }
  end

  def schedule_onsite_meetings
    onsite_meetings.each do |meeting|
      schedule.push(schedule_entry_for_meeting(meeting))
    end
  end

  def travel_to(meeting, start_time = current_end_of_schedule)
    {
      name: "Travel to #{meeting[:name]}",
      type: :travel,
      start_time: start_time,
      end_time: time_module.add_time_length_to_start_time(TRAVEL_DURATION, start_time)
    }
  end

  def first_meeting_of_day?
    schedule.empty?
  end

  def schedule_offsite_meetings
    offsite_meetings.each do |meeting|
      schedule.push(travel_to(meeting)) unless first_meeting_of_day?
      schedule.push(schedule_entry_for_meeting(meeting))
    end
  end

  def schedule_all_meetings
    schedule_onsite_meetings
    schedule_offsite_meetings
  end

  def schedule_excluding_travel
    schedule.reject { |m| m[:type] == :travel }
  end

  def schedule_for_print
    schedule_excluding_travel.map do |meeting|
      start_time = time_module.military_to_12_hour(meeting[:start_time])
      end_time = time_module.military_to_12_hour(meeting[:end_time])
      "#{start_time} - #{end_time} - #{meeting[:name]}"
    end
  end

  def proposed_schedule
    schedule_all_meetings

    return false if time_module.time_is_after_end_of_day(current_end_of_schedule)

    schedule_for_print
  end
end
