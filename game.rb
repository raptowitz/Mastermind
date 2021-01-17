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

  def color_move
    @player_guess.map { |guess| color(guess) }
  end

  def place_move(player_guess, red_hints, grey_hints, round)
    @player_guess = player_guess
    @red_hints = red_hints
    @grey_hints = grey_hints
    @round = round

    @board[@round] = color_move
    @board[@round].push(@red_hints)
    @board[@round].push(@grey_hints)
  end
end

# Random computer player
class Computer
  attr_reader :secretcode
  def initialize
    @choices = %w[r g y b m c]
    @secretcode = []
  end

  def create_secret_code
    4.times do
      @select = rand(6)
      @secretcode.push(@choices[@select])
    end
    p @secretcode
  end
end

# Player Guesser
class Player
  attr_reader :player_guess
  def initialize
    @choices = %w[r g y b m c]
  end

  def guess_code
    puts 'Guess the secret code!'
    @player_guess = gets.chomp.split(//)
    validate_guess
    @player_guess
  end

  def validate_guess
    until @player_guess.all? { |guess| @choices.include?(guess) } &&
          @player_guess.length == 4
      puts 'Guess 4 colors: r, g, y, b, m, c'
      @player_guess = gets.chomp.split(//)
    end
  end
end

# Game logic
class Game
  include Colors

  def initialize(computer, player, board)
    @computer = computer
    @player = player
    @board = board
    @round = 0
  end

  def play_game
    @computer.create_secret_code
    12.times do
      @board.print_board
      @board.place_move(@player.guess_code, red_hints, grey_hints, @round)
      break if @red_pegs.length == 4

      @round += 1
    end
    @board.print_board
    puts 'You cracked the code!'
  end

  def red_hints
    @red_pegs = []
    @red_decoded = []
    @player.player_guess.each_with_index do |guess, index|
      next unless guess == @computer.secretcode[index]

      @red_pegs.push(red_peg)
      @red_decoded.push(index)
    end
    @red_pegs
  end

  def grey_hints
    @grey_pegs = []
    @grey_decoded = []
    @player.player_guess.each do |guess|
      @computer.secretcode.each_with_index do |code, index|
        next unless guess == code && @red_decoded.none?(index) && @grey_decoded.none?(index)

        @grey_pegs.push(grey_peg)
        @grey_decoded.push(index)
        break
      end
    end
    @grey_pegs
  end
end

new_game = Game.new(Computer.new, Player.new, Board.new)
new_game.play_game

# puts "guess is #{guess} matches code #{code}. code index #{code_index} is not a red 
# peg in #{@red_decoded} and code index #{code_index} is not a grey peg in #{@grey_decoded}"
