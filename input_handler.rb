class InputHandler
  def initialize
    @stdin = STDIN #標準入力(ユーザーから文字列を受け取るときのため)
  end

  def get_user_input()
    loop do
      print "数字を3桁入力してください（スペース区切り）: "
      line = @stdin.gets&.chomp.to_s #ユーザーが入力した値が文字列で取得される
      inputs = line.split(' ') # 入力されたスペース区切りの文字列を配列に変換

      if inputs.length != 3
        if !line.include?(' ')
          puts 'スペース区切りで入力してください（例: 1 2 3）'
        else
          puts '桁数が正しくありません。'
        end
        next #もう一度最初から
      end

      guess = []
      duplicate_found = false
      invalid_found = false

      #重複した数値があるかどうかチェック
      inputs.each do |s|
        begin
          num = Integer(s)
        rescue ArgumentError
          puts '入力エラー: 数字のみをスペース区切りで入力してください。'
          invalid_found = true
          break
        end
        if guess.include?(num)
          puts '入力エラー: 重複した数字があります。'
          duplicate_found = true
          break
        end
        guess << num
      end
      next if duplicate_found || invalid_found
      return guess
    end
  end
end

