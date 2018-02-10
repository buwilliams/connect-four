class BasicAi
  attr_accessor :board

  # def: find next move

  # takes in a board
  # creates a new board
  # assigns board from one given
  # loops through all possible moves
  # for each move
  #   loops through all opponents next moves
  #     if any move results in game lose pass scope up

  def next_move(board)
    @board = board
  end

  private

  def possible_moves
    @board.width.times do |pos|
      slot = pos + 1
      tmp_board = Board.new(@board.width, @board.height)
      tmp_board.board = @board.board.clone
    end
  end
end
