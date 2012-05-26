require_relative 'pong/thing'
require_relative 'pong/paddle'
require_relative 'pong/ball'
require_relative 'pong/frame'
require_relative 'pong/renderer'

module Pong
  extend self

  def run
    renderer = Renderer.new
    renderer.run
  end
end