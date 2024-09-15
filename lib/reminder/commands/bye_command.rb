module Reminder
  class ByeCommand < Reminder::Command
    def initialize(msg)
      @msg = msg
    end

    def execute
      Reminder::Config.bot.api.send_message(chat_id: @msg.chat.id, text: "Bye, #{@msg.from.first_name}")
    end
  end
end