class InputHandler
  def initialize
    @stdin = STDIN #標準入力(ユーザーから文字列を受け取るときのため)
  end

  def get_user_input()
    loop do
      print "数字を3桁入力してください（スペース区切りまたは連続入力）: "
      line = @stdin.gets&.chomp.to_s
      # スペース区切りか、連続入力か判定
      if line.include?(' ')
        inputs = line.split(' ')
      else
        inputs = line.chars
      end
      if inputs.length != 3
        puts '桁数が正しくありません。'
        next
      end

      guess = []
      duplicate_found = false

      inputs.each do |s|
        begin
          num = Integer(s)
        rescue ArgumentError
          puts '入力エラー: 数字のみを入力してください。'
          duplicate_found = true
          break
        end
        if guess.include?(num)
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

