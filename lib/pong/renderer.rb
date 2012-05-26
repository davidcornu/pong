module Pong
  class Renderer
    attr_accessor :screen_height, :screen_width

    def initialize
      self.screen_width  = `tput cols`.to_i
      self.screen_height = `tput lines`.to_i - 1
      @frame = new_frame
    end

    def run
      ball = Ball.new
      paddle = Paddle.new
      direction = :none

      while true do
        ball.move!(@frame)
        paddle.move!(@frame, get_input)
        direction = :none
        render(ball, paddle)
        sleep 0.05
      end
    end

    private

    def render(*objects)
      @frame = new_frame
      objects.each {|object| @frame.add(object) }
      clear
      print @frame.output
    end

    def clear
      print "\e[2J\e[f"
    end

    def new_frame
      Frame.new(screen_width, screen_height)
    end

    def get_input
      begin
        system("stty raw -echo")
        begin
          case STDIN.read_nonblock(1)
          when 'w'
            :up
          when 's'
            :down
          else
            :none
          end
        rescue Errno::EAGAIN
          :none
        end
      ensure
        system("stty -raw echo")
      end
    end
  end
end