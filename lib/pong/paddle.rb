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
      self.x = 1
      self.y = 10
      reset_directions
    end

    def move!(frame, direction)
      if direction == :none
        current_direction = last_direction
      else
        current_direction = direction
      end

      cant_go_up   = (current_direction == :up && self.y == frame.height)
      cant_go_down = (current_direction == :down && self.y - self.height + 1 == 1)

      if cant_go_up || cant_go_down
        current_direction = :none
        reset_directions
      else
        case current_direction
        when :up
          self.y += 1
        when :down
          self.y -= 1
        end
        track_direction(direction)
      end
    end

    private

    def reset_directions
      @direction_history = [:none, :none, :none]
    end

    def track_direction(direction)
      @direction_history.pop
      @direction_history.unshift(direction)
    end

    def last_direction
      @direction_history.each do |direction|
        return direction if direction != :none
      end
      return :none
    end
  end
end