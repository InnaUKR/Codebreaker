class Game
  CODE_LENGTH = 4
  RANGE_OF_NUMBERS = (1..6)
  DIFFICULTY = {
    easy: { attempts: 30, hints: 3 },
    medium: { attempts: 15, hints: 2 },
    hard: { attempts: 10, hints: 1 }
  }.freeze
  SCORES_FILE_PATH = 'lib/codebreaker/src/statistic.txt'.freeze

  attr_reader :difficulty, :attempts_numb, :hints_numb

  def initialize(ui = Console.new, score = TextFileScores.new)
    @ui = ui
    @score = score
  end

  def start
    loop do
      generate_secret_code
      difficulty_setting
      play
      propose_save
      break unless @ui.play_again?
    end
  end

  private

  def generate_secret_code
    @secret_code = Array.new(CODE_LENGTH) { Random.rand(RANGE_OF_NUMBERS) }
  end

  def difficulty_setting
    @difficulty = @ui.choose_difficulty
    choose_difficulty
  end

  def choose_difficulty
    level = DIFFICULTY[@difficulty.to_sym]
    @attempts_numb = level[:attempts]
    @hints_numb = level[:hints]
    @gotten_hints = []
  end

  def play
    loop do
      @ui.show_info(@attempts_numb, @hints_numb)
      @attempts_numb -= 1
      propose_hint
      pluses_numb, minuses_numb = mark(get_guess_code)
      return @ui.win_game if pluses_numb == CODE_LENGTH
      @ui.show_result(pluses_numb, minuses_numb)
      break if @attempts_numb.zero?
    end
    @ui.lose_game
  end

  def propose_hint
    while @hints_numb > 0
      break unless @ui.take_hint?
      hint = take_hint
      @ui.show_hint(hint)
    end
  end

  def propose_save
    return until @ui.save?
    name = @ui.ask_name
    @score.save_game(SCORES_FILE_PATH, name, self)
  end

  def get_guess_code
    guess_string = @ui.make_guess
    guess_code = guess_string.split('').map(&:to_i)
    get_guess_code unless guess_code.length == CODE_LENGTH &&
                          guess_code.all? { |number| RANGE_OF_NUMBERS.include?(number) }
    guess_code
  end

  def take_hint
    index = nil
    loop do
      index = Random.rand(0...CODE_LENGTH)
      break unless @gotten_hints.include?(index)
    end
    @gotten_hints << index
    @hints_numb -= 1
    @secret_code[index]
  end

  def mark(guess_code)
    pluses_numb, secret_code, guess_code = count_pluses(guess_code)
    minuses_numb = count_minuses(guess_code, secret_code)
    [pluses_numb, minuses_numb]
  end

  def count_pluses(guess_code)
    secret_code, guess_code = remove_bulls(guess_code)
    pluses_numb = CODE_LENGTH - secret_code.length
    [pluses_numb, secret_code, guess_code]
  end

  def remove_bulls(guess_code)
    secret_code, guess_code = @secret_code.zip(guess_code).reject\
     { |s, g| s == g }.transpose
    [secret_code.to_a, guess_code.to_a]
  end

  def count_minuses(guess_code, secret_code)
    guess_code.count do |x|
      index = secret_code.find_index(x)
      secret_code.delete_at(index) if index
    end
  end
end
