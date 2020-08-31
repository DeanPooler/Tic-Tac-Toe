# frozen_string_literal: true

# rubocop:disable Style/OneLineConditional
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
require 'pry'

# a game that involves two players, placing X's and O's on a 3x3 grid, until one of the players
# has three of their marks adjacent to eachother (Either horizontally, vertically, or diagonally)

# The game class contains an initialized board class and two initialized player classes
# It also has the method for the game loop which checks for wins/losses
class Game
  attr_accessor :board
  def initialize
    @moves_made = 0
    @board = Board.new
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @win = false
    start
  end

  def game_loop
    while @win == false
      turn(@player1)
      turn(@player2)
    end
  end

  def turn(player)
    print 'Enter move:'
    board.make_move(gets.chomp.to_sym, player.symbol)
    puts
    win_condition?(@board.hash)
    board.show
  end

  def start
    puts 'How many rounds do you want to play?'
    rounds = gets.to_i
    rounds.times do
      game_loop
    end
  end

  def win_condition?(board)
    @win = true if board[:A1] != '.' && board[:A1] == board[:A2] && board[:A1] == board[:A3]
    @win = true if board[:A1] != '.' && board[:A1] == board[:B1] && board[:A1] == board[:C1]
    @win = true if board[:A1] != '.' && board[:A1] == board[:B2] && board[:A1] == board[:C1]
    @win = true if board[:A2] != '.' && board[:A2] == board[:B2] && board[:A2] == board[:C2]
    @win = true if board[:B1] != '.' && board[:B1] == board[:B2] && board[:B1] == board[:B3]
    @win = true if board[:C1] != '.' && board[:C1] == board[:C2] && board[:C1] == board[:C3]
    @win = true if board[:A3] != '.' && board[:A3] == board[:B3] && board[:A3] == board[:C3]
    @win = true if board[:A3] != '.' && board[:A3] == board[:B2] && board[:A3] == board[:C1]
    @win
  end
end

# The board class contains a hash with nine spots (or "moves")
# It also has the methods for making moves
class Board
  attr_accessor :hash
  def initialize
    @hash = {
      A1: '.', A2: '.', A3: '.',
      B1: '.', B2: '.', B3: '.',
      C1: '.', C2: '.', C3: '.'
    }
  end

  def show
    @hash.each_with_index do |(_key, value), index|
      if ((index + 1) % 3).zero? then puts value else print "#{value} | " end
    end
  end

  def make_move(place, player)
    hash[place.to_sym] = player
  end
end

# The player class contains the symbol that the players uses and
# the amount of wins they have
class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end
end

game = Game.new
game.game_loop
