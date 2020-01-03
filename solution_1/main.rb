require_relative 'scheduler'

test_meetings = [
  { name: "Meeting 1", duration: 3, type: :onsite },
  { name: "Meeting 2", duration: 2, type: :offsite },
  { name: "Meeting 3", duration: 1, type: :offsite },
  { name: "Meeting 4", duration: 0.5, type: :onsite }
]


scheduler = Scheduler.new(test_meetings)
puts scheduler.proposed_schedule
