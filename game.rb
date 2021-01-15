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

  def place_move(player_guess, round)
    @player_guess = player_guess
    @round = round
    @color_guess = []

    @player_guess.each do |guess|
      @color_guess.push(color(guess))
    end
    @board[@round] = @color_guess
  end
end

# Random computer player
class Computer
  def initialize
    @choices = ['r', 'g', 'y', 'b', 'm', 'c', '']
    @secretcode = []
  end

  def create_secret_code
    4.times do
      @selection = rand(7)
      @secretcode.push(@choices[@selection])
    end
  end
end

# Player Guesser
class Player
  def guess_code
    puts 'Guess the secret code!'
    gets.chomp.split(//)
  end
end

# Game logic
class Game
  def initialize(computer, player, board)
    @computer = computer
    @player = player
    @board = board
    @round = nil
  end

  def play_game
    @round = 0
    12.times do
      @board.print_board
      @computer.create_secret_code
      @board.place_move(@player.guess_code, @round)
      @round += 1
    end
  end
end

new_game = Game.new(Computer.new, Player.new, Board.new)
new_game.play_game
