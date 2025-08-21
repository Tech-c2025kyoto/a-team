require_relative 'answer_generator'
require_relative 'judge'
require_relative 'input_handler'
require_relative 'result'

class Game
  def initialize
    @answer = AnswerGenerator.generate_answer(3) # @はインスタンス変数
    @judge = Judge.new
    @input_handler = InputHandler.new
  end

  def start
    puts '=== Hit and Blowゲームをスタートします ==='

    loop do
      guess = @input_handler.get_user_input()
      result = @judge.evaluate(@answer, guess)
      puts "ヒット: #{result.hits}, ブロー: #{result.blows}"

      if result.hits == @answer.length
        puts '正解です！'
        break
      end
    end
  end
end

