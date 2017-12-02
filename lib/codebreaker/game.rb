#module Codebreaker
  class Game
    CODE_LENGTH = 4
    RANGE_OF_NUMBERS = (1..6)

    def initialize
    end

    def start
      @secret_code = generate_secret_code
    end

    def guess(guess_string)
      guess_code = guess_string.split('').map(&:to_i)
      while @secret_code != guess_code
        mark(guess_code)
      end
    end


    private

    def generate_secret_code
      CODE_LENGTH.times.map{ Random.rand(RANGE_OF_NUMBERS) }
    end

    def mark(guess_code)
      secret_code, guess_code = remove_bulls(guess_code)
      pluses_numb = CODE_LENGTH - secret_code.length
      minuses_numb = count_minuses(guess_code, secret_code)
      result = pluses_numb + minuses_numb
    end

    def remove_bulls(guess_code)
      secret_code = @secret_code
      secret_code, guess_code = @secret_code.zip(guess_code).reject\
       { |s, g| s == g }.transpose
      [secret_code, guess_code]
    end

    def count_minuses(guess_code, secret_code)
      guess_code.count do |x|
        index = secret_code.find_index(x)
        secret_code.delete_at(index) if index
      end
    end

  end
#end

#p game.guess('1234')
#p game.match([1,2,3,4])
