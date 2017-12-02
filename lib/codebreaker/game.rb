#module Codebreaker
  class Game
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
      4.times.map{ Random.rand(1..6) }
    end

    def mark(guess_code)
      copy_secret_code = @secret_code
      pluses_arr, copy_secret_code = mark_pluses(guess_code, copy_secret_code)
      minuses_arr, copy_secret_code = mark_minuses(guess_code, copy_secret_code)
      result = pluses_arr + minuses_arr
    end

    def mark_pluses(guess_code, copy_secret_code)
      result = []
      @secret_code.each_with_index do |x, index|
        if x == guess_code[index]
          result << '+'
          copy_secret_code -= [x]
        end
      end
      [result, copy_secret_code]
    end

    def mark_minuses(guess_code, copy_secret_code)
      result = []
      guess_code.each do |x|
        if copy_secret_code.include?(x)
          result << '-'
          copy_secret_code -= [x]
        end
      end
      [result, copy_secret_code]
    end

  end
#end

#p game.guess('1234')
#p game.match([1,2,3,4])
