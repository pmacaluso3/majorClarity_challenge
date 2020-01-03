require_relative 'workday_time'

test_meetings = [
  { name: "Meeting 1", duration: 3, type: :onsite },
  { name: "Meeting 2", duration: 2, type: :offsite },
  { name: "Meeting 3", duration: 1, type: :offsite },
  { name: "Meeting 4", duration: 0.5, type: :onsite }
]


def frontload_onsite_meetings(meetings)
  onsite_meetings = meetings_of_type(meetings, :onsite)
  offsite_meetings = meetings_of_type(meetings, :offsite)
  onsite_meetings.concat(offsite_meetings)
end

def meetings_of_type(meetings, type)
  meetings.select { |m| m[:type].to_sym == type.to_sym }
end

def assign_times_to_onsite_meetings(meetings)

end


def pad_travel_time_into_offsite_meetings(meetings)

end


def propose_schedule(meetings)

end


propose_schedule(test_meetings)

