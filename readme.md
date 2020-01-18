# Usage
```
cd /your/path/to/majorClarity_challenge/solution_1
ruby main.rb
```

# Why is there a dir called solution_1
This is the first approach I came up with, but I don't think it's the best way. So I intend to do a version that addresses the problems listed below. However, I got the challenge before christmas vacation and I'm turning it in afterwards, so I wanted to put something up asap.

# Shortcomings of this solution
- It relies on the strategy of frontloading all onsite meetings. If you needed to have an offsite meeting in the morning for any reason, you'd be out of luck. All-onsites-together-in-the-morning is an ok default strategy, but ideally you could specify other schedule restrictions.
- It relies on there only being 2 kinds of meetings, offsite and onsite. Ideally it should have an expandable list of meeting types (containing only offsite and onsite for now), and instructions for how to pad the different types with travel times. For example:
  - onsite-to-onsite: 0 padding
  - onsite-to-offsite: 0.5 hours padding
  - offsite-to-offsite: 0.5 hours padding
This reliance is also baked into how travel time is handled at start-of-day; this case would ideally also be part of the meeting-types list.
- It would be better to use a standard time library, but I wrote it without wifi access and couldn't look at the ruby Time library docs.
