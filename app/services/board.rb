class Board
  attr_accessor :width, :height, :board, :turn

  PLAYER_ONE = 1
  PLAYER_TWO = 2
  WINS = {
    horizontal:     [[0,0], [1,0], [2,0], [3,0]],
    vertical:       [[0,0], [0,1], [0,2], [0,3]],
    diaginal_right: [[0,0], [1,1], [2,2], [3,3]],
    diaginal_left:  [[0,0], [-1,1], [-2,2], [-3,3]]
  }

  def initialize(width, height, game_over_callback=->{})
    @width = width
    @height = height
    @game_over_callback = game_over_callback
    reset
  end

  def reset
    @board = clean_board
    @turn = PLAYER_ONE
    @moves_made = 0
    @game_over = false
  end

  def move(slot)
    x = slot - 1
    index = open_index(x)

    return false if index == -1

    if @turn == PLAYER_ONE
      @turn = PLAYER_TWO
      @board[index] = 1
    else
      @turn = PLAYER_ONE
      @board[index] = 2
    end

    @moves_made += 1

    # TODO: check for four in a row

    # check for draw
    if @moves_made >= @width * @height
      @game_over_callback.call
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

  def moves_from_pattern(pattern, x, y)
    #puts "Pattern: #{pattern}"
    moves = pattern.map do |coordinates|
      new_x = x + coordinates[0]
      new_y = y + coordinates[1]
      index = index_from_coords(new_x, new_y)
      #puts "Coords: #{coordinates}, Index: #{index}"
      if index == -1
        next nil
      else
        next @board[index]
      end
    end
    moves
  end

  def win?(matches)
    matched = moves.reduce(movies.first) do |result, current|
      return nil if result.nil?
      if current == result
        return current
      else
        return nil
      end
    end
  end

  private

  def open_index(x)
    index = -1
    return index if x > (@width - 1)
    @height.times do |row|
      check_index = index_from_coords(x, row)
      if @board[check_index].nil?
        index = check_index
        break
      end
    end
    index
  end

  def index_from_coords(x, y)
    index = ((y + 1) * width) - width + x
    return -1 if (index + 1) > @board.size
    return index
  end

  def coords_from_index(index)
    # TODO
  end
end
