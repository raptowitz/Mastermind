# frozen_String_literal: true

# display board
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
    @guess.map { |guess| color(guess) }
  end

  def place_move(guess, red_hints, grey_hints, round)
    @guess = guess
    @red_hints = red_hints
    @grey_hints = grey_hints
    @round = round
    puts "\e[H\e[2J"
    @board[@round] = color_move
    @board[@round].push(@red_hints)
    @board[@round].push(@grey_hints)
  end
end
