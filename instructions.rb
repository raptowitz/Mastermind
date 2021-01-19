# frozen_String_literal: true

# instructions to begin the game
module Instructions
  def instructions
    puts 'Welcome to MASTERMIND!'
    puts "\nThis is a 1-player console game where you can be a code BREAKER or a code MAKER"
    puts "\nThe code MAKER will choose a four letter code from the following six colors:"
    puts "\e[41m r \e[0m \e[42m g \e[0m \e[43m y \e[0m \e[44m b \e[0m \e[45m m \e[0m \e[46m c \e[0m"
    puts "\nThe code BREAKER will have 12 chances to guess the code and win the game."
    puts "\nAfter each guess the code BREAKER will recieve up to 4 red or grey hints."
    puts "\nA red hint \e[31m●\e[0m means the guess has a correct color in a correct position."
    puts "A grey hint \e[37m●\e[0m means the guess has a correct color in an INCORRECT position."
  end
end
