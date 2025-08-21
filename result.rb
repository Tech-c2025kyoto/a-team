# hit数とblow数を持つためのクラス
class Result
  attr_reader :hits, :blows

  def initialize(hits, blows)
    @hits = hits
    @blows = blows
  end
end

