class ConnectFour
  attr_accessor :board, :game_over

  def initialize(width, height)
    @game = [nil, nil]
    @board = Board.new(width, height, ->(result) { @game = result })
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
      slot = STDIN.gets.chomp
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
end
