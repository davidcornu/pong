module Pong
  class Thing
    attr_accessor :x, :y, :width, :height, :vector, :sprite

    def initialize
      self.x = 1
      self.y = 1
      self.vector = [1,1]
      workout_dimensions
    end

    def next_position
      [self.x + vector[0], self.y + vector[1]]
    end

    def move!(frame)
      if within_bounds?(frame, next_position)
        self.x, self.y = next_position
      end
      return self
    end

    def workout_dimensions
      self.width, self.height = sprite.max_by(&:length), sprite.size
    end

    private

    def within_bounds?(frame, coords = nil)
      coords ||= [self.x, self.y]
      [
        coords[0] >= 1,
        coords[1] >= 1,
        coords[0] <= frame.width,
        coords[1] <= frame.height
      ].all?
    end

    def collisions(frame, coords = nil)
      coords ||= [self.x, self.y]
      collisions = []
      collisions << :left   if coords[0] == 1
      collisions << :right  if coords[0] == frame.width
      collisions << :bottom if coords[1] == 1
      collisions << :top    if coords[1] == frame.height
      return collisions
    end
  end
end