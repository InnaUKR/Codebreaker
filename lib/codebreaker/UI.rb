class UI
  def show_sentence(_parameter)
    raise 'Abstract method called.'
  end

  def ask_phrase(_parameter)
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

  def win_game(_flag)
    raise 'Abstract method called.'
  end
end
