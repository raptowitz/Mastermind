# frozen_String_literal: true

require_relative 'instructions.rb'
require_relative 'colors.rb'
require_relative 'hints.rb'
require_relative 'board.rb'
require_relative 'computer.rb'
require_relative 'player.rb'
require_relative 'game.rb'

new_game = Game.new(Computer.new, Player.new, Board.new)
new_game.play_game
