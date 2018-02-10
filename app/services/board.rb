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

  def initialize(width, height, game_over_callback=->(r){})
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
    index = find_open_index(x)

    return false if index == -1

    if @turn == PLAYER_ONE
      @board[index] = 1
      @turn = PLAYER_TWO
    else
      @board[index] = 2
      @turn = PLAYER_ONE
    end

    @moves_made += 1

    # detect win condition
    result = detect_win
    if result[0] != nil
      @game_over_callback.call result
      return true
    end

    # detect draw
    if @moves_made >= @width * @height
      @game_over_callback.call [0, nil]
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

  def detect_win
    (@board.size - 1).times do |index|
      next if @board[index].nil?
      coords = coords_from_index(index)
      result = match_win_patterns(coords[0], coords[1])
      if result[0] != nil
        return result
      end
    end
    return [nil, nil]
  end

  def match_win_patterns(x, y)
    WINS.keys.each do |key|
      result = players_and_coords(WINS[key], x, y)
      player = reduce_players(result[0])
      return [player, result[1]] if player == 1 or player == 2
    end
    return [nil, nil]
  end

  def players_and_coords(pattern, x, y)
    positions = []
    moves = pattern.map do |coordinates|
      new_x = x + coordinates[0]
      new_y = y + coordinates[1]
      positions << [new_x, new_y]
      index = index_from_coords(new_x, new_y)
      if index == -1
        nil
      else
        @board[index]
      end
    end
    [moves, positions]
  end

  private

  def find_open_index(x)
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
    return nil if index > (@board.size - 1)
    return nil if index < 0
    x = (index + @width) % @width
    y = ((index + @width) / @width) - 1
    return [x, y]
  end

  def reduce_players(positions)
    positions.reduce(positions.first) do |result, current|
      next nil if result.nil?
      if current == result
        next current
      else
        next nil
      end
    end
  end
end
