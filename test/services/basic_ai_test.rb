require 'test_helper'

class BasicAiTest < ActiveSupport::TestCase
  test "makes a random move" do
    b = Board.new(7, 6)
    ai = BasicAi.new
    m = ai.move(b)
    b.move(m)
    assert_equal(1, b.moves_made)
  end

  test "AI can play against AI" do
    b = Board.new(7, 6)
    p1 = BasicAi.new
    p2 = BasicAi.new
    21.times do
      m = p1.move(b)
      b.move(m)

      m = p2.move(b)
      b.move(m)
    end
    assert_equal(42, b.moves_made)
    assert_equal(true, b.game_over?)
  end

  test "AI makes winning move as player1 depth of 1" do
    b = Board.new(7, 6)
    p1 = BasicAi.new 1
    3.times { b.move(1); b.move(2) }
    b.move p1.move(b)
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n" * 2
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, b.render)
    assert_equal(true, b.won?)
  end

  test "AI makes winning move as player2 depth of 1" do
    b = Board.new(7, 6)
    p2 = BasicAi.new 1
    3.times { b.move(1); b.move(2) }
    b.move 3
    b.move p2.move(b)
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n" * 2
    expected += "[ ][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][x][ ][ ][ ][ ]\n"
    assert_equal(expected, b.render)
    assert_equal(true, b.won?)
  end

  test "AI makes prevents winning move as player 2 depth of 1" do
    b = Board.new(7, 6)
    p2 = BasicAi.new 2
    2.times { b.move(1); b.move(2) }
    b.move 1
    b.move p2.move(b)
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n" * 2
    expected += "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, b.render)
    assert_equal(false, b.won?)
  end
end
