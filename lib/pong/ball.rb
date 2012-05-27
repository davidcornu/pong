module Pong
  class Ball < Thing

    def initialize
      self.sprite = [['o']]
      self.x = 2
      self.y = 2
      super
    end

    def move!(frame)
      collisions = frame.collisions(self)
      bounce!(collisions) unless collisions.size == 0
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