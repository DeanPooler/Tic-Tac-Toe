# frozen_string_literal: true

# a game that involves two players, placing X's and O's on a 3x3 grid, until one of the players
# has three of their marks adjacent to eachother (Either horizontally, vertically, or diagonally)

# This class handles: the game loop, and win conditions
class Game
  attr_reader :board, :player1
  def initialize
    @moves_made = 0
    @board = Board.new
    @player1 = Player.new('x')
  end

  def start_game; end
end

# this class handles the game board
class Board < Game
  attr_accessor :board
  def initialize
    @board = {
      A1: '.', A2: '.', A3: '.',
      B1: '.', B2: '.', B3: '.',
      C1: '.', C2: '.', C3: '.'
    }
  end

  def show
    board.each_with_index do |(_key, value), index|
      if ((index + 1) % 3).zero?
        puts value
      else
        print "#{value} | "
      end
    end

    def get_board
      board
    end

    def set_board(place, symbol)
      board[place] = symbol
    end
  end
end

# this class handles: Making moves in the grid, and keeping score
class Player < Game
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def get_symbol
    symbol
  end
end

game = Game.new

game.board.show
puts ''
game.board.set_board(game.board.board['A1'], game.player1.get_symbol)
game.board.show
