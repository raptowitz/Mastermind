# frozen_String_literal: true

# red and white hint pegs
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
