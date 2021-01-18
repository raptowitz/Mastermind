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

# pegs
module Hints
  def red_peg
    "\e[31m●\e[0m"
  end

  def grey_peg
    "\e[37m●\e[0m"
  end

  def red_hints(guess, secretcode)
    @guess = guess
    @secretcode = secretcode
    @red_pegs = []
    @red_decoded = []
    @guess.each_with_index do |letter, index|
      next unless letter == @secretcode[index]

      @red_pegs.push(red_peg)
      @red_decoded.push(index)
    end
    @red_pegs
  end

  def grey_hints
    @grey_pegs = []
    @grey_decoded = []
    @guess.each_with_index do |letter, letter_index|
      @secretcode.each_with_index do |code, code_index|
        next unless letter == code && @grey_decoded.none?(code_index) &&
                    @red_decoded.none?(letter_index) &&
                    @red_decoded.none?(code_index)

        @grey_pegs.push(grey_peg)
        @grey_decoded.push(code_index)
        break
      end
    end
    @grey_pegs
  end
end

# Board
class Board
  include Colors
  attr_reader :red_pegs

  def initialize
    @board = Array.new(12) { Array.new(4, blank) }
  end

  def print_board
    @board.each do |row|
      puts row.join
    end
  end

  def color_move
    @guess.map { |guess| color(guess) }
  end

  def place_move(guess, red_hints, grey_hints, round)
    @guess = guess
    @red_hints = red_hints
    @grey_hints = grey_hints
    @round = round
    #puts "\e[H\e[2J"
    @board[@round] = color_move
    @board[@round].push(@red_hints)
    @board[@round].push(@grey_hints)
  end
end

# Random computer player
class Computer
  include Hints
  attr_reader :secretcode
  def initialize
    @choices = %w[r g y b m c]
  end

  def create_secret_code
    @secretcode = []
    4.times do
      @select = rand(6)
      @secretcode.push(@choices[@select])
    end
    @secretcode = %w[r r y b]
  end

  def guess_code(round, secretcode)
    @round = round
    @secretcode = secretcode
    @possible_codes = [['r', 'r', 'r', 'g'], ['r', 'r', 'r', 'y'], ['r', 'r', 'r', 'b'], ['r', 'y', 'r', 'b']]
    # @choices.permutation(4).to_a

    if @round.zero?
      @computer_guess = %w[r r g g]
      @red_guess = red_hints(@computer_guess, @secretcode)
      @grey_guess = grey_hints
      # returns array without things that are true for the condition
      @possible_codes = @possible_codes.reject do |guess|
        red_hints(guess, @computer_guess).length != @red_guess.length ||
          grey_hints.length != @grey_guess.length
      end
      p @possible_codes

    end

    # @computer_guess = []
    # 4.times do
    #   @select = rand(6)
    #   @computer_guess.push(@choices[@select])
    # end
    @computer_guess
  end
end

# Player Guesser
class Player
  attr_reader :player_guess, :secretcode
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

# Game logic
class Game
  include Colors
  include Hints
  attr_reader :round

  def initialize(computer, player, board)
    @computer = computer
    @player = player
    @board = board
    @round = 0
    @secretcode = nil
  end

  def play_game
    create_secret_code
    1.times do
      @board.print_board
      @board.place_move(guess, red_hints(@guess, @secretcode), grey_hints, @round)
      break if @red_pegs.length == 4

      @round += 1
    end
    @board.print_board
    display_results
  end

  def guess
    @guess = if @player_role == 'b'
               @player.guess_code
             else
               @computer.guess_code(@round, @secretcode)
             end
    @guess
  end

  def create_secret_code
    puts 'Would you like to be a code breaker (key b) or a code maker (key m)?'
    @player_role = gets.chomp
    if @player_role == 'b'
      @secretcode = @computer.create_secret_code
    elsif @player_role == 'm'
      @secretcode = @player.create_secret_code
    else
      valid_role
    end
    @secretcode
  end

  def valid_role
    until @player_role == 'b' || @player_role == 'm'
      puts "Enter 'b' or 'm'"
      @player_role = gets.chomp
    end
    if @player_role == 'b'
      @secretcode = @computer.create_secret_code
    elsif @player_role == 'm'
      @secretcode = @player.create_secret_code
    end
  end

  def display_results
    if @red_pegs.length == 4
      puts "\nThe code was cracked!"
    else
      puts "\nAll right, then. Keep your secrets. (shh...code was #{@secretcode})"
    end
  end
end

new_game = Game.new(Computer.new, Player.new, Board.new)
new_game.play_game
