module Pong
  class Paddle < Thing
    def initialize
      self.sprite = [
        ['|'],
        ['|'],
        ['|']
      ]
      super
      self.y = 10
    end

    def move!(frame, direction)
      case direction
      when :up
        self.y += 1
      when :down
        self.y -= 1
      end
    end
  end
end