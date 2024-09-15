module Reminder
  class Helpers
    def self.parse_time_to_cron(schedule_time)
      hour, min = schedule_time.split(':').map(&:to_i)
      Time.new(Time.now.year, Time.now.month, Time.now.day, hour, min)
    end
  end
end