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

  def choose_difficulty
    show_sentence(@phrases[:choose_difficulty])
    @phrases[:difficulty].each { |x| puts x }
    ask_phrase(:enter_difficulty)
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

  def win_game(flag)
    parameter = flag ? @phrases[:win] : @phrases[:lose]
    show_sentence(parameter)
  end
end
