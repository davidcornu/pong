module Pong
  class Ball < Thing
    def initialize
      self.sprite = [['o']]
      super
    end

    def move!(frame)
      bounce!(collisions(frame)) unless within_bounds?(frame, next_position)
      self.x, self.y = next_position
      return self
    end

    private

    def bounce!(collisions)
      if collisions.any? {|c| [:left, :right].include?(c) }
        self.vector[0] = vector[0] * -1
      end

      if collisions.any? {|c| [:top, :bottom].include?(c) }
        self.vector[1] = vector[1] * -1
      end
    end
  end
end