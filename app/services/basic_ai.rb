class BasicAi
  attr_accessor :board

  # Steps:
  # - random move, depth 1
  # - random move but consider opponents best move, depth 2
  # - arbitrary depth

  def move(game_board)
    moves = game_board.available_moves
    moves.sample
  end
end
