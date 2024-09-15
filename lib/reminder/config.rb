module Reminder
  class Config
    GROUP_ID = ENV.fetch('GROUP_ID')
    CHAT_ID = ENV.fetch('CHAT_ID')
    BOT_TOKEN = ENV.fetch('BOT_TOKEN')

    class << self
      attr_accessor :bot
    end

    def initialize(bot)
      self.class.bot = bot
    end
  end
end
