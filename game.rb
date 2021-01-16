# frozen_String_literal: true

# Terminal output colors
module Colors
  def red
    "\e[41mr\e[0m"
  end

  def green
    "\e[42mg\e[0m"
  end

  def yellow
    "\e[43my\e[0m"
  end

  def blue
    "\e[44mb\e[0m"
  end

  def magenta
    "\e[45mm\e[0m"
  end

  def cyan
    "\e[46mc\e[0m"
  end

  def blank
    "\e[47m?\e[0m"
  end

  def color(guess)
    case guess
    when 'r' then red
    when 'g' then green
    when 'y' then yellow
    when 'b' then blue
    when 'm' then magenta
    when 'c' then cyan
    else blank
    end
  end

  def red_peg
    "\e[31m●\e[0m"
  end

  def grey_peg
    "\e[37m●\e[0m"
  end
end

# Board
class Board
  include Colors

  def initialize
    @board = Array.new(12) { Array.new(4, blank) }
  end

  def print_board
    @board.each do |row|
      puts row.join
    end
  end

  def place_move(player_guess, red_pegs, round)
    @player_guess = player_guess
    @red_pegs = red_pegs
    @round = round
    @color_guesses = []

    @player_guess.each do |guess|
      @color_guesses.push(color(guess))
    end

    @board[@round] = @color_guesses
    @board[@round].push(@red_pegs)
  end
end

# Random computer player
class Computer
  attr_reader :secretcode
  def initialize
    @choices = ['r', 'g', 'y', 'b', 'm', 'c', '']
    @secretcode = []
  end

  def create_secret_code
    4.times do
      @select = rand(7)
      @secretcode.push(@choices[@select])
    end
    puts @secretcode
  end
end

# Player Guesser
class Player
  attr_reader :player_guess

  def guess_code
    puts 'Guess the secret code!'
    @player_guess = gets.chomp.split(//)
  end
end

# Game logic
class Game
  include Colors

  def initialize(computer, player, board)
    @computer = computer
    @player = player
    @board = board
  end

  def play_game
    @round = 0
    @computer.create_secret_code
    12.times do
      @board.print_board
      @board.place_move(@player.guess_code, red_pegs, @round)
      @round += 1
    end
  end

  def red_pegs
    @red_pegs = []
    @player.player_guess.each_with_index do |guess, index|
      if guess == @computer.secretcode[index]
        @red_pegs.push(red_peg)
      else
        grey_pegs(guess)
      end
    end
    @red_pegs
  end

  def grey_pegs(guess)
    @guess = guess
    puts grey_peg if @computer.secretcode.include?(@guess)
  end
end

new_game = Game.new(Computer.new, Player.new, Board.new)
new_game.play_game
