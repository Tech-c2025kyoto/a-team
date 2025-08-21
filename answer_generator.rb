class AnswerGenerator
  def self.generate_answer(length) # selfは自分自身を指すクラスメソッド(静的メソッド,staticメソッド)
    digits = (0..9).to_a
    digits.shuffle! # !があるとレシーバー自体を変更する(破壊的メソッド)
    digits.first(length)
  end
end

