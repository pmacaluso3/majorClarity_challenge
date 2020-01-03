require_relative 'workday_time'

class Scheduler
  attr_reader :meetings, :time_module
  attr_accessor :schedule

  def initialize(meetings, time_module = WorkdayTime)
    @meetings = meetings
    @time_module = time_module
    @schedule = []
  end

  # def frontload_onsite_meetings(meetings)
  #   onsite_meetings = meetings_of_type(meetings, :onsite)
  #   offsite_meetings = meetings_of_type(meetings, :offsite)
  #   onsite_meetings.concat(offsite_meetings)
  # end

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

  def assign_times_to_onsite_meetings
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


  def pad_travel_time_into_offsite_meetings(meetings)

  end


  def propose_schedule(meetings)

  end


end


