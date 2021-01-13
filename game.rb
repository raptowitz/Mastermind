# frozen_String_literal: true

# Terminal output colors
module Colors
  def colorize(code)
    @code = code
    "\e[#{code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def hello
    puts 'hello'.red
  end
end

# Board
class Board
  include Colors

  def initialize
    @board = Array.new(12) { Array.new(4, '?') }
  end

  def print_board
    @board.each do |row|
      puts row.join
    end
  end
end

class Computer
  
end


new_board = Board.new
new_board.print_board
