class Board
  attr_accessor :width, :height, :board, :turn, :moves_made, :all_moves

  PLAYER_ONE = 1
  PLAYER_TWO = 2
  WINS = {
    horizontal:     [[0,0], [1,0], [2,0], [3,0]],
    vertical:       [[0,0], [0,1], [0,2], [0,3]],
    diagonal_right: [[0,0], [1,1], [2,2], [3,3]],
    diagonal_left:  [[0,0], [-1,1], [-2,2], [-3,3]]
  }

  def initialize(width, height, game_over_callback=->(r){})
    @width = width
    @height = height
    @game_over_callback = game_over_callback
    @all_moves = []
    reset_board
  end

  def reset_board
    @board = clean_board
    @turn = PLAYER_ONE
    @moves_made = 0
    @game_over = false
  end

  def move(slot, skip_detection=false)
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

    @all_moves << slot
    @moves_made += 1

    # save some cycles
    return true if skip_detection

    # detect win condition
    result = detect_win
    if result[0] != nil
      @game_over_callback.call result
      return true
    end

    # detect draw
    @game_over_callback.call [0, nil] if tie?

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

  def game_over?
    won? or tie?
  end

  def won?
    (detect_win()[0].nil?) ? false : true
  end

  def tie?
    (@moves_made >= (@width * @height) and won? == false) ? true : false
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
      result = match_pattern(WINS[key], x, y)
      player = reduce_players(result[0])
      return [player, result[1]] if player == 1 or player == 2
    end
    return [nil, nil]
  end

  # not a private method since I'm using this
  # in the tests
  def match_pattern(pattern, x, y)
    coords = []
    players = pattern.map do |coordinates|
      new_x = x + coordinates[0]
      new_y = y + coordinates[1]
      coords << [new_x, new_y]
      index = index_from_coords(new_x, new_y)
      if index == -1
        nil
      else
        @board[index]
      end
    end
    [players, coords]
  end

  def available_moves
    moves = []
    @width.times do |x|
      index = find_open_index x
      moves << (x + 1) unless index == -1
    end
    moves
  end

  def auto_move(moves)
    moves.each { |m| move(m) }
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
    return -1 if x > (@width - 1) or x < 0 or y > (@height - 1) or y < 0
    index = ((y + 1) * width) - width + x
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
