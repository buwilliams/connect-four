class BasicAi
  attr_accessor :depth, :board, :loops

  NEUTRAL = 0
  WIN = 1000
  LOSS = -1000

  def initialize(depth=0)
    @depth = depth
    @loops = 0
  end

  # Steps:
  # - random move, depth 1
  # - random move but consider opponents best move, depth 2
  # - arbitrary depth

  def move(game_board)
    @loops = 0
    
    if @depth == 0
      # makes a random move
      moves = game_board.available_moves
      moves.sample
    else
      # uses depth look ahead
      scores = look_ahead(game_board, @depth)
      moves = game_board.available_moves
      move_from_scores moves, scores
    end
  end

  def look_ahead(game_board, max_depth=5)
    current_depth = 1
    is_maximizer = true
    moves = game_board.available_moves

    scores = moves.map do |m|
      @loops += 1
      cloned = clone_board(game_board)
      cloned.move(m)

      if cloned.won? and is_maximizer
        next WIN
      elsif cloned.won? and !is_maximizer
        next LOSS
      elsif cloned.tie?
        next NEUTRAL
      elsif current_depth == max_depth
        # two matched spots with open spots = 2
        # three match (with open spots) = 3
        next NEUTRAL
      else
        next score_board(cloned, !is_maximizer, current_depth + 1, max_depth)
      end
    end

    scores
  end

  def score_board(game_board, is_maximizer, current_depth, max_depth=5)
    @loops += 1
    moves = game_board.available_moves
    scores = moves.map do |m|
      cloned = clone_board(game_board)
      cloned.move(m)

      if cloned.won? and is_maximizer
        next WIN
      elsif cloned.won? and !is_maximizer
        next LOSS
      elsif cloned.tie?
        next NEUTRAL
      elsif current_depth == max_depth
        # two matched spots with open spots = 2
        # three match (with open spots) = 3
        next NEUTRAL
      else
        # TODO: this returns an array but needs to return value
        # next 0
        next score_board(cloned, !is_maximizer, current_depth + 1, max_depth)
      end
    end

    if is_maximizer
      score = LOSS
      scores.each do |s|
        score = s if s > score
      end
      return score
    else
      score = WIN
      scores.each do |s|
        score = s if s < score
      end
      return score
    end
  end

  private

  def move_from_scores(moves, scores)
    score_to_beat = LOSS
    move_indices = []

    scores.each_with_index do |val, index|
      if val == score_to_beat
        move_indices << index
      elsif val > score_to_beat
        move_indices = [index]
        score_to_beat = val
      end
    end

    moves[move_indices.sample]
  end

  def clone_board(board)
    cloned_board = Board.new(board.width, board.height)
    cloned_board.board = board.board.clone
    cloned_board.turn = board.turn
    cloned_board
  end
end
