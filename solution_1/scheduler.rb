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

  def schedule_onsite_meetings
    onsite_meetings.each do |meeting|
      start_of_meeting = current_end_of_schedule
      end_of_meeting = time_module.add_time_length_to_start_time(meeting[:duration], start_of_meeting)
      schedule.push({
        name: meeting[:name],
        type: meeting[:type],
        start_time: start_of_meeting,
        end_time: end_of_meeting
      })
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

  def schedule_offsite_meetings
    offsite_meetings.each do |meeting|
      schedule.push(travel_to(meeting))
      start_of_meeting = current_end_of_schedule
      end_of_meeting = time_module.add_time_length_to_start_time(meeting[:duration], start_of_meeting)
      schedule.push({
        name: meeting[:name],
        type: meeting[:type],
        start_time: start_of_meeting,
        end_time: end_of_meeting
      })
    end
  end


  def schedule_all_meetings
    schedule_onsite_meetings
    schedule_offsite_meetings
  end
end


