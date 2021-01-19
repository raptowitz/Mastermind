# frozen_String_literal: true

# instructions to begin the game
module Instructions
  def instructions
    puts 'Welcome to MASTERMIND!'
    puts "\n This is a 1-player console game where you can be the code BREAKER or the code MAKER"
    puts "The code MAKER will choose a four letter code from the following six colors:"
    puts "\e[41m r \e[0m \e[42m g \e[0m \e[43m y \e[0m"
  end
  
    # def blue
    #   "\e[44m b \e[0m"
    # end
  
    # def magenta
    #   "\e[45m m \e[0m"
    # end
  
    # def cyan
    #   "\e[46m c \e[0m"
    # end
  
    # def blank
    #   "\e[47m ? \e[0m"
    # end
end
