class ConnectFour
  attr_accessor :board, :game_over, :ai_player, :is_ai_first

  PLAYER_HUMAN = 1
  PLAYER_AI = 2

  def initialize(width, height, ai_player=nil, is_ai_first=false)
    @game = [nil, nil]
    @board = Board.new(width, height, ->(result) { @game = result })
    @ai_player = ai_player
    @is_ai_first = is_ai_first
  end

  def play
    while @game[0] == nil
      20.times { puts }
      puts "Connect Four"
      puts "-" * @board.width * 3
      @board.width.times { |n| print "(#{n+1})"}
      puts
      @board.paint
      puts "-" * @board.width * 3
      print "Player #{@board.turn}'s turn: "
      slot = get_move
      @board.move slot.to_i
    end
    20.times { puts }
    puts "Connect Four"
    puts "-" * @board.width * 3
    @board.width.times { |n| print "(#{n+1})"}
    puts
    @board.paint
    puts "-" * @board.width * 3
    puts "Player #{@game[0]} wins!!!"
  end

  def get_move
    if @board.turn == Board::PLAYER_ONE and @is_ai_first == true
      ai_move
    elsif @board.turn == Board::PLAYER_TWO and !@ai_player.nil?
      ai_move
    else
      human_move
    end
  end

  def human_move
    m = STDIN.gets.chomp
    m.to_i
  end

  def ai_move
    @ai_player.move(@board)
  end
end
