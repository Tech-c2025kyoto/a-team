require_relative 'result'

class Judge
  def evaluate(answer, guess)
    hits = 0 # 位置も数値も一致
    blows = 0 # 位置は一致していないが、数値は一致している

    guess.each_with_index do |g, i|
      if g == answer[i]
        hits += 1
      elsif answer.include?(g)
        blows += 1
      end
    end

    Result.new(hits, blows)
  end
end

