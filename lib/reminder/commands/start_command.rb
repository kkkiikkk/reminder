module Reminder
  class StartCommand < Reminder::Command
    def initialize(msg)
      @msg = msg
    end

    def execute
      puts @msg.chat.id
      Reminder::Config.bot.api.send_message(chat_id: @msg.chat.id, text: "INIT")
    end
  end
end