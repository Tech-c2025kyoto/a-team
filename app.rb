require_relative 'game'

class App
  def self.main
    loop do
      game = Game.new
      game.start

      # ▼ y/n 以外は再入力させるループ
      retry_input = nil
      loop do
        print 'もう一度プレイしますか？ (y/n): '
        retry_input = gets.chomp.downcase
        break if %w[y n].include?(retry_input)
        puts '無効な入力です。y または n を入力してください。'
      end

      break if retry_input == 'n'
    end

    puts 'ゲームを終了します。ありがとうございました！'
  end
end

App.main