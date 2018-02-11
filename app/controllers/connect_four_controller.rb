class ConnectFourController < ApplicationController
  def index
  end

  def move
    width = params[:width]
    height = params[:height]
    game_mode = params[:game_mode]
    moves = params[:moves]

    b = Board.new(width, height)
    b.auto_move(moves)

    win_results = b.detect_win

    # Game mode is AI
    if game_mode > 0 && win_results[0].nil?
      ai = BasicAi.new (game_mode - 1)
      b.move ai.move(b)
      win_results = b.detect_win
    end

    game_over = (!win_results[0].nil? or b.tie?) ? true : false

    render json: {
      game_over: game_over,
      moves: b.all_moves,
      current_players_turn: b.turn,
      coords: win_results[1],
      winner: win_results[0]
    }
  end
end
