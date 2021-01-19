# frozen_String_literal: true

# Game logic
class Game
  include Colors
  include Hints
  include Instructions
  attr_reader :round

  def initialize(computer, player, board)
    @computer = computer
    @player = player
    @board = board
    @round = 0
  end

  def play_game
    instructions
    create_secret_code
    12.times do
      @board.print_board
      @board.place_move(guess, red_hints(@guess, @secretcode), grey_hints, @round)
      break if @red_pegs.length == 4

      @round += 1
    end
    @board.print_board
    display_results
    play_again
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

  def play_again
    puts 'Play again? (y/n)'
    if gets.chomp == 'y'
      puts "\e[H\e[2J"
      new_game = Game.new(Computer.new, Player.new, Board.new)
      new_game.play_game
    else
      puts 'Thanks for playing friend!'
    end
  end
end
