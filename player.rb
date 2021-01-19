# frozen_String_literal: true

# Player Guesser
class Player
  def initialize
    @choices = %w[r g y b m c]
  end

  def create_secret_code
    puts 'Enter 4 letter secret code (choices: r g y b m c)'
    @secretcode = gets.chomp.split(//)
    @secretcode = validate(@secretcode)
    @secretcode
  end

  def guess_code
    puts 'Guess the secret code! (choices: r g y b m c)'
    @player_guess = gets.chomp.split(//)
    validate(@player_guess)
  end

  def validate(guess)
    @guess = guess
    until @guess.all? { |letter| @choices.include?(letter) } &&
          @guess.length == 4
      puts 'Choose 4 colors: r, g, y, b, m, c'
      @guess = gets.chomp.split(//)
    end
    @guess
  end
end
