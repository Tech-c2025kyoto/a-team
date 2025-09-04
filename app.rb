require_relative 'game'

class App
  def self.main
    loop do
      game = Game.new
      game.start

      print 'もう一度プレイしますか？ (y/n): '
      answer = gets.chomp.downcase
      break unless answer == 'y'
    end

    puts 'ゲームを終了します。ありがとうございました！'
  end
end

App.main
