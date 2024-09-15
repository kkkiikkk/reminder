require 'rufus-scheduler'

module Reminder
  class Jobs
    def initialize
      @scheduler = Rufus::Scheduler.new

      @schedule = [
        {
          time: '22:40',
          title: "Комп'ютерна логіка",
          link: 'https://meet.google.com/ecq-furq-hbq'
        },
        {
          time: '09:25',
          title: "Об'єктно-орієнтоване програмування",
          link: 'https://meet.google.com/mcg-icgj-fnq'
        }
      ]
    end

    def perform
      @schedule.each do |item|
        reminder_time = Reminder::Helpers.parse_time_to_cron(item[:time])

        @scheduler.at(reminder_time) do
          send_reminder(item[:title], item[:link])
        end
      end

      @scheduler.join
    end

    def send_reminder(title, link)
      message = "#{title} \n#{link}"
      
      Reminder::Config.bot.api.send_message(chat_id: Reminder::Config::CHAT_ID, text: message)
    end
  end
end
