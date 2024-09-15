require 'telegram/bot'
require 'dotenv/load'
require_relative './reminder/jobs'
require_relative './reminder/config'
require_relative './reminder/helpers'
require_relative './reminder/commands/command'
require_relative './reminder/commands/start_command'
require_relative './reminder/commands/bye_command'

module Reminder
  class << self
    def start
      jobs_thread = Thread.new do
        jobs = Reminder::Jobs.new
        jobs.perform
      end

      bot_thread = Thread.new do
        Telegram::Bot::Client.run(Reminder::Config::BOT_TOKEN) do |bot|
          Reminder::Config.new(bot)
          Reminder::Config.bot.listen do |msg|
            if msg.is_a?(Telegram::Bot::Types::Message)
              case msg.text
              when '/start'
                start_command = Reminder::StartCommand.new(msg)
                start_command.execute
              when '/stop'
                bye_command = Reminder::ByeCommand.new(msg)
                bye_command.execute
              end
            else
              puts "Received non-message update: #{msg.class}"
            end
          end
        end
      end

      [jobs_thread, bot_thread].each(&:join)
    end
  end
end
