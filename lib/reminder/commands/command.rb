module Reminder
  class Command
    def execute
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end