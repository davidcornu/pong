module Pong
  class Frame
    attr_accessor :width, :height, :pixels, :objects, :message

    def initialize(width, height)
      self.width, self.height = width, height - 1
      self.build_pixels
      self.message = ''
      self.objects = []
    end

    def build_pixels
      self.pixels = []
      (1..height).each do
        pixels << (1..width).map { ' ' }
      end
    end

    def add(object)
      self.objects << object

      plot_points(object).each do |coords, char|
        if pixels[coords[0]].nil? || pixels[coords[0]][coords[1]].nil?
          raise "#{object.class.name} out of bounds at (#{object.x}, #{object.y})"
        else
          self.pixels[coords[0]][coords[1]] = char
        end
      end
    end

    def output
      pixels.map {|row| row.join('') }.join("\n") + footer
    end

    def collisions(object)
      return boundary_collisions(object) + object_collisions(object)
    end

    def boundary_collisions(object)
      collisions = []
      collisions << :top    if object.y == self.height
      collisions << :bottom if object.y - object.height + 1 == 1
      collisions << :left   if object.x == 1
      collisions << :right  if object.x + object.width - 1 == self.width
      return collisions
    end

    def object_collisions(object)
      collisions = []
      cur_points = plot_points(object)
      (self.objects.reject {|o| o == object }).each do |object|
        plot_points(object).keys.each do |point|
          collisions << :left   if cur_points.include?([point[0], point[1] + 1])
          collisions << :right  if cur_points.include?([point[0], point[1] + 1])
          collisions << :top    if cur_points.include?([point[0] - 1, point[1]])
          collisions << :bottom if cur_points.include?([point[0] + 1, point[1]])
        end
      end
      return collisions
    end

    private

    def plot_points(object)
      points = {}
      col_index = object.x - 1
      row_index = (height - 1) - (object.y - 1)

      object.sprite.each_with_index do |row, cur_row_index|
        row.each_with_index do |char, cur_col_index|
          points[[row_index + cur_row_index, col_index + cur_col_index]] = char
        end
      end

      return points
    end

    def footer
      text = " " + (message.length > 0 ? message : 'Pong')
      ["\n", "\x1b[7m", text, (1..width - text.length - 1).map{' '}.join(''), "\033[0m"].join('')
    end
  end
end