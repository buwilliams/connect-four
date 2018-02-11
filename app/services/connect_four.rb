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
      clear_screen
      puts "Connect Four"
      puts "-" * @board.width * 3
      @board.width.times { |n| print "(#{n+1})"}
      puts
      @board.paint
      puts "-" * @board.width * 3
      print "Player #{@board.turn}'s turn: "
      move_player
    end
    clear_screen
    puts "Connect Four"
    puts "-" * @board.width * 3
    @board.width.times { |n| print "(#{n+1})"}
    puts
    @board.paint
    puts "-" * @board.width * 3
    puts "Moves: #{@board.all_moves}"
    puts "Coords for win: #{@game[1]}"
    puts "Player #{@game[0]} wins!!!"
  end

  def move_player
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
    if m[0] == '['
      m[1..-2].split(',').each do |m|
        puts "Auto playing: #{m.to_i}"
        @board.move m.to_i
      end
    else
      @board.move m.to_i
    end
  end

  def ai_move
    @board.move @ai_player.move(@board).to_i
  end

  def clear_screen
    40.times { puts }
  end
end
