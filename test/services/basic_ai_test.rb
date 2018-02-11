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
end
