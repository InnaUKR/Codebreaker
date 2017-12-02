# module Codebreaker
class Game
  CODE_LENGTH = 4
  RANGE_OF_NUMBERS = (1..6)

  def initialize; end

  def start
    @secret_code = generate_secret_code
  end

  def guess(guess_string)
    guess_code = guess_string.split('').map(&:to_i)
    mark(guess_code) while @secret_code != guess_code
  end

  private

  def generate_secret_code
    Array.new(CODE_LENGTH) { Random.rand(RANGE_OF_NUMBERS) }
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
# end
