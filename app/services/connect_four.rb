class ConnectFour
  attr_accessor :width, :height, :board, :turn

  PLAYER_ONE = 1
  PLAYER_TWO = 2

  def initialize(width, height)
    @width = width
    @height = height
    reset
  end

  def reset
    @board = clean_board
    @turn = PLAYER_ONE
  end

  def move(slot)
    index = open_index(slot)

    return false if index == -1

    if @turn == PLAYER_ONE
      @turn = PLAYER_TWO
      @board[index] = 1
    else
      @turn = PLAYER_ONE
      @board[index] = 2
    end

    return true
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

  private

  def open_index(slot)
    index = -1
    @height.times do |row|
      check_index = row_slot_index(row, slot)
      if @board[check_index].nil?
        index = check_index
        break
      end
    end
    index
  end

  def row_slot_index(row, slot)
    index = ((row + 1) * width) - width + slot - 1
    return -1 if (index + 1) > @board.size
    return index
  end
end
