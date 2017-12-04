class UI
  def play_again?
    raise 'Abstract method called.'
  end

  def take_hint?
    raise 'Abstract method called.'
  end

  def save?
    raise 'Abstract method called.'
  end

  def ask_name
    raise 'Abstract method called.'
  end

  def make_guess
    raise 'Abstract method called.'
  end

  def show_hint(_hint)
    raise 'Abstract method called.'
  end

  def choose_difficulty
    raise 'Abstract method called.'
  end

  def show_info(_attempts_numb, _hints_numb)
    raise 'Abstract method called.'
  end

  def show_result(_pluses_numb, _minuses_numb)
    raise 'Abstract method called.'
  end

  def win_game
    raise 'Abstract method called.'
  end

  def lose_game
    raise 'Abstract method called.'
  end
end
