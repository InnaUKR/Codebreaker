class TextFileScores < Scores
  def save_game(file, name, game)
    File.open(file, 'a') do |f|
      f.puts("#{name}, #{game.difficulty}, #{game.attempts_numb}, #{game.hints_numb}")
    end
  end
end
