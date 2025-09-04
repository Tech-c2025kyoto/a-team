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
    puts "=== Hit and Blowゲーム（#{@length}桁）をスタートします ==="
    max_attempts = 10
    start_time = Time.now # 最大試行回数を設定

    max_attempts.times do |i|
      remaining = max_attempts - i
      puts "残り試行回数: #{remaining}"
      guess = @input_handler.get_user_input()
      result = @judge.evaluate(@answer, guess)
      puts "ヒット: #{result.hits}, ブロー: #{result.blows}"

      if result.hits == @answer.length
        end_time = Time.now  # ★ゲーム終了時間を記録
        time_taken = (end_time - start_time).round(2)
        puts '正解です！'
        puts '正解までの試行回数: ' + (i + 1).to_s + '回'
        puts "所要時間: #{time_taken}秒"
        break
      elsif remaining == 1
        puts "ゲームオーバー！正解は #{@answer.join} でした。" #Array.joinメソッド:配列の要素を文字列として結合する
        end_time = Time.now
        time_taken = (end_time - start_time).round(2)
        puts "スコア: 試行回数 #{i + 1}回 / 所要時間 #{time_taken}秒"
      end
    end
  end
end

