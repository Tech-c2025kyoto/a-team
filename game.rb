require_relative 'answer_generator'
require_relative 'judge'
require_relative 'input_handler'
require_relative 'result'

class Game
  def initialize
    @answer = AnswerGenerator.generate_answer(3) # @はインスタンス変数
    @judge = Judge.new
    @input_handler = InputHandler.new
    @history = [] # 入力履歴を保持
  end

  # 運ゲーイベントを処理するメソッド
  def luck_event(current_attempts, max_attempts)
    # 25%の確率で運ゲーイベントが発生
    return max_attempts if rand(100) >= 25
    
    event_type = rand(3) # 0, 1, 2のいずれか
    
    case event_type
    when 0 # ラッキーイベント：試行回数+2
      bonus = 2
      puts "🍀 ラッキー！ 神様が微笑みました！試行回数が#{bonus}回増加しました！"
      max_attempts + bonus
    when 1 # 普通のラッキーイベント：試行回数+1
      bonus = 1
      puts "✨ ちょっとラッキー！試行回数が#{bonus}回増加しました！"
      max_attempts + bonus
    when 2 # アンラッキーイベント：試行回数-1（ただし最低1回は保証）
      penalty = 1
      new_max = [max_attempts - penalty, current_attempts + 1].max
      if new_max < max_attempts
        puts "💀 アンラッキー...試行回数が#{penalty}回減少しました..."
      else
        puts "💀 アンラッキー...でしたが、最低限の試行回数は保証されます"
      end
      new_max
    end
  end

  def start
    puts "=== Hit and Blowゲーム（#{@answer.length}桁）をスタートします ==="
    puts "🎲 今回は運ゲー要素が追加されています！回答後に試行回数が変動する可能性があります！"
    max_attempts = 10
    start_time = Time.now # ゲーム開始時刻
    attempts_used = 0

    loop do
      attempts_used += 1

      # 入力履歴を表示（2回目以降）
      unless @history.empty?
        puts "\n--- 過去の入力履歴 ---"
        @history.each_with_index do |item, index|
          puts "#{index + 1}回目: 入力: #{item[:guess].join(' ')}, 結果: #{item[:hits]}ヒット, #{item[:blows]}ブロー"
        end
        puts "----------------------"
      end

      remaining = max_attempts - attempts_used + 1
      puts "\n--- 第#{attempts_used}回目の挑戦 ---"
      puts "残り試行回数: #{remaining}"
      
      guess = @input_handler.get_user_input()
      result = @judge.evaluate(@answer, guess)
      @history << { guess: guess, hits: result.hits, blows: result.blows }

      puts "ヒット: #{result.hits}, ブロー: #{result.blows}"

      if result.hits == @answer.length
        end_time = Time.now  # ★ゲーム終了時間を記録
        time_taken = (end_time - start_time).round(2)
        puts '🎉 正解です！'
        puts "正解までの試行回数: #{attempts_used}回"
        puts "所要時間: #{time_taken}秒"
        break
      end

      # 運ゲーイベントの発生（ゲーム終了でない場合のみ）
      old_max = max_attempts
      max_attempts = luck_event(attempts_used, max_attempts)
      
      if max_attempts != old_max
        change = max_attempts - old_max
        puts "最大試行回数が #{old_max} → #{max_attempts} に変更されました (#{change > 0 ? '+' : ''}#{change})"
      end

      # ゲームオーバー判定
      if attempts_used >= max_attempts
        puts "\n💥 ゲームオーバー！正解は #{@answer.join} でした。" # Array.joinで答えを表示
        end_time = Time.now
        time_taken = (end_time - start_time).round(2)
        puts "スコア: 試行回数 #{attempts_used}回 / 所要時間 #{time_taken}秒"
        break
      end
    end
  end
end
