class ConnectFour
  attr_accessor :width, :height, :board

  PLAYER_ONE = 1
  PLAYER_TWO = 2

  def initialize(width, height)
    @width = width
    @height = height
    @board = clean_board
  end

  def move(player, slot)
    if player == PLAYER_ONE
      @board[slot - 1] = 1
    else
      @board[slot - 1] = 2
    end
  end

  def render
    out = []
    str = ""
    @board.size.times do |index|
      if @board[index].nil?
        str += '[ ]'
      elsif @board[index] == 1
        str += '[x]'
      elsif @board[index] == 2
        str += '[o]'
      end

      if (index + 1) % @width == 0
        out << str
        str = ""
      end
    end
    out.reverse.join("\n") + "\n"
  end

  def paint
    puts render
  end

  def clean_board
    Array.new(@width * @height, nil)
  end
end
