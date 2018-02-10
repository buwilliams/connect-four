class ConnectFour
  attr_accessor :board, :game_over

  def initialize(width, height)
    @game_over = false
    @board = Board.new(width, height, -> { @game_over = true })
  end

  def play
    while @game_over == false
      20.times { puts }
      puts "Connect Four"
      puts "-" * @board.width * 3
      @board.width.times { |n| print "(#{n+1})"}
      puts
      @board.paint
      puts "-" * @board.width * 3 
      print "Player #{@board.turn}'s turn: "
      slot = STDIN.gets.chomp
      @board.move slot.to_i
    end
    puts "Game over. Player #{@board.turn} wins!!!"
  end
end
