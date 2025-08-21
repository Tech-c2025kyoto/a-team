class InputHandler
  def initialize
    @stdin = STDIN #標準入力(ユーザーから文字列を受け取るときのため)
  end

  def get_user_input()
    loop do
      print "数字を3桁入力してください（スペース区切り）: "
      line = @stdin.gets&.chomp.to_s #ユーザーが入力した値が文字列で取得される
      inputs = line.split(' ') # 入力されたスペースが
      if inputs.length != 3
        puts '桁数が正しくありません。'
        next #もう一度最初から
      end

      guess = []
      duplicate_found = false

      #重複した数値があるかどうかチェック
      inputs.each do |s|
        num = Integer(s)
        if guess.include?(num) # guess配列にその数値が含まれているかどうか
          puts '入力エラー: 重複した数字があります。'
          duplicate_found = true
          break
        end
        guess << num
      end
      next if duplicate_found
      return guess
    end
  end
end

