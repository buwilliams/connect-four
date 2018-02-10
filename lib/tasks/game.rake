namespace :game do
  desc "Play classic Connect 4 (human-vs-human 7x6 board)"
  task standard: :environment do
    c = ConnectFour.new(7, 6)
    c.play
  end
end
