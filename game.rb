# frozen_String_literal: true

# Terminal output colors
module Colors
  def red(text)
    "\e[41m#{text}\e[0m"
  end

  def green(text)
    "\e[42m#{text}\e[0m"
  end

  def yellow(text)
    "\e[43m#{text}\e[0m"
  end

  def blue(text)
    "\e[44m#{text}\e[0m"
  end

  def magenta(text)
    "\e[45m#{text}\e[0m"
  end

  def cyan(text)
    "\e[46m#{text}\e[0m"
  end

  def gray(text)
    "\e[47m#{text}\e[0m"
  end
end

# Board
class Board
  include Colors

  def initialize
    @board = Array.new(12) { Array.new(4, gray('?')) }
  end

  def print_board
    @board.each do |row|
      puts row.join
    end
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
  end

  def play_game
    @board.print_board
    @computer.create_secret_code
    @player.guess_code
  end
end

new_game = Game.new(Computer.new, Player.new, Board.new)
new_game.play_game
