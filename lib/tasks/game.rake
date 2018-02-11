namespace :game do
  desc "Play classic Connect 4 (human-vs-human 7x6 board)"
  task classic: :environment do
    c = ConnectFour.new(7, 6)
    c.play
  end

  task easy: :environment do
    ai = BasicAi.new
    c = ConnectFour.new(7, 6, ai)
    c.play
  end
end
