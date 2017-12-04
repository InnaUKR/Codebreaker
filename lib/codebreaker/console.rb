require 'yaml'
class Console < UI
  PHRASES_PATH = 'lib/codebreaker/src/phrases.yml'.freeze

  def initialize
    @phrases = YAML.load_file(PHRASES_PATH)
  end

  def show_sentence(parameter)
    puts parameter
  end

  def ask_phrase(parameter)
    puts @phrases[parameter.to_sym]
    gets.chomp
  end

  def play_again?
    ask_phrase(:play_again) == 'y'
  end

  def take_hint?
    p ask_phrase(:hint_message) == 'y'
  end

  def save?
    ask_phrase(:ask_save) == 'y'
  end

  def ask_name
    ask_phrase(:ask_name)
  end

  def make_guess
    ask_phrase(:enter_numbers)
  end

  def show_hint(hint)
    puts hint
  end

  def choose_difficulty
    show_sentence(@phrases[:choose_difficulty])
    @phrases[:difficulty].each { |x| puts x }
    puts @phrases[:enter_difficulty]
    gets.chomp
  end

  def show_info(attempts_numb, hints_numb)
    show_sentence @phrases[:separator]
    show_sentence 'attempts: ' + attempts_numb.to_s
    show_sentence 'hints: ' + hints_numb.to_s
    show_sentence @phrases[:separator]
  end

  def show_result(pluses_numb, minuses_numb)
    show_sentence pluses_numb.to_s + '+'
    show_sentence minuses_numb.to_s + '-'
  end

  def win_game
    show_sentence(@phrases[:win])
  end

  def lose_game
    show_sentence(@phrases[:lose])
  end
end
