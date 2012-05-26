module Pong
  class Paddle < Thing
    def initialize
      self.sprite = [
        ['|'],
        ['|'],
        ['|'],
        ['|'],
        ['|']
      ]
      super
      self.y = 10
      @last_direction = :none
    end

    def move!(frame, direction)
      if @last_direction != :none && direction == :none
        current_direction = @last_direction
      else
        current_direction = direction
      end

      case current_direction
      when :up
        self.y += 1
      when :down
        self.y -= 1
      end

      @last_direction = direction
    end
  end
end