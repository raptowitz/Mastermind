# frozen_String_literal: true

# Computer player, implents Swaszek strategy when codebreaker
class Computer
  include Hints

  def initialize
    @choices = %w[r g y b m c]
  end

  def create_secret_code
    @secretcode = []
    4.times do
      @select = rand(6)
      @secretcode.push(@choices[@select])
    end
    @secretcode
  end

  def guess_code(round, secretcode)
    @round = round
    @secretcode = secretcode
    if @round.zero?
      @computer_guess = %w[r r g g]
      @possible_codes = @choices.repeated_permutation(4).to_a
    else
      @computer_guess = @possible_codes[0]
    end
    reduce_possibilities
    @computer_guess
  end

  def reduce_possibilities
    @red_guess = red_hints(@computer_guess, @secretcode)
    @grey_guess = grey_hints
    @possible_codes = @possible_codes.reject do |guess|
      red_hints(@computer_guess, guess).length != @red_guess.length ||
        grey_hints.length != @grey_guess.length
    end
    @possible_codes
  end
end
