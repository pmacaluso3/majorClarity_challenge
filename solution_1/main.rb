require_relative 'scheduler'

test_meetings = {
  example_0: [
    { name: "Meeting 1", duration: 3, type: :onsite },
    { name: "Meeting 2", duration: 2, type: :offsite },
    { name: "Meeting 3", duration: 1, type: :offsite },
    { name: "Meeting 4", duration: 0.5, type: :onsite }
  ],
  example_1: [
    { name: "Meeting 1", duration: 1.5, type: :onsite },
    { name: "Meeting 2", duration: 2, type: :offsite },
    { name: "Meeting 3", duration: 1, type: :onsite },
    { name: "Meeting 4", duration: 1, type: :offsite },
    { name: "Meeting 5", duration: 1, type: :offsite },
  ],
  example_2: [
    { name: "Meeting 1", duration: 4, type: :offsite },
    { name: "Meeting 2", duration: 4, type: :offsite }
  ],
  example_3: [
    { name: "Meeting 1", duration: 0.5, type: :offsite },
    { name: "Meeting 2", duration: 0.5, type: :onsite },
    { name: "Meeting 3", duration: 2.5, type: :offsite },
    { name: "Meeting 4", duration: 3, type: :onsite }
  ],
    example_4: [
    { name: "Meeting 1", duration: 3.5, type: :offsite },
    { name: "Meeting 2", duration: 4, type: :offsite }
  ],
}

test_meetings.each do |test_name, test_data|
  puts "====================#{test_name}===================="
  scheduler = Scheduler.new(test_data)
  if (proposed_schedule = scheduler.proposed_schedule)
    puts "Yes, can fit. One possible solution would be:"
    puts proposed_schedule
  else
    puts "No, can’t fit."
  end
end

