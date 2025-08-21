require_relative 'game' #requireの場合は絶対指定、require_relativeは相対指定

class App
  def self.main
    game = Game.new
    game.start
  end
end

App.main

