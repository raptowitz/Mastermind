# frozen_String_literal: true

# Terminal output colors
module Colors
  def red
    "\e[41m r \e[0m"
  end

  def green
    "\e[42m g \e[0m"
  end

  def yellow
    "\e[43m y \e[0m"
  end

  def blue
    "\e[44m b \e[0m"
  end

  def magenta
    "\e[45m m \e[0m"
  end

  def cyan
    "\e[46m c \e[0m"
  end

  def blank
    "\e[47m ? \e[0m"
  end

  def color(guess)
    case guess
    when 'r' then red
    when 'g' then green
    when 'y' then yellow
    when 'b' then blue
    when 'm' then magenta
    when 'c' then cyan
    end
  end
end
