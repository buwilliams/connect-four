class ConnectFour
  attr_accessor :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def render
    (("[ ]" * @width) + "\n") * @height
  end

  def paint
    puts render
  end
end
