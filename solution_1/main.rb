test_meetings = [
  { name: "Meeting 1", duration: 3, type: :onsite },
  { name: "Meeting 2", duration: 2, type: :offsite },
  { name: "Meeting 3", duration: 1, type: :offsite },
  { name: "Meeting 4", duration: 0.5, type: :onsite }
]


def frontload_onsite_meetings(meetings)
  onsite_meetings = meetings.select { |m| m[:type].to_sym == :onsite }
  offsite_meetings = meetings.select { |m| m[:type].to_sym == :offsite }
  onsite_meetings.concat(offsite_meetings)
end




def propose_schedule(meetings)

end


propose_schedule(test_meetings)
