module Pong
  class Frame
    attr_accessor :width, :height, :pixels

    def initialize(width, height)
      self.width, self.height = width, height
      self.build_pixels
    end

    def build_pixels
      self.pixels = []
      (1..height).each do
        pixels << (1..width).map { ' ' }
      end
    end

    def add(object)
      col_index = object.x - 1
      row_index = (height - 1) - (object.y - 1)

      object.sprite.each_with_index do |row, cur_row_index|
        row.each_with_index do |char, cur_col_index|
          pixels[row_index + cur_row_index][col_index + cur_col_index] = char
        end
      end
    end

    def output
      pixels.map {|row| row.join('') }.join("\n")
    end
  end
end