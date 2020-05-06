#!/usr/bin/env ruby
# frozen_string_literal: true

# LIBRARY
class ChessGame
  PIECE_NAMES =
    Hash.new('empty boxes').merge!(
      'K' => 'king',
      'P' => 'pawn',
      'Q' => 'queen',
      'R' => 'rook',
      'B' => 'bishop'
    ).freeze

  attr_reader :board

  def initialize(board)
    check_input(board)

    @board = board

    localize_king
  end

  def check
    ### Check the 2 horizontal directions (left and right) for R & Q ###
    board[0..king_posy]
      .map { |line| line[king_posx] }
      .reverse_each do |piece|
        case piece
        when 'P', 'B'
          break
        when 'R', 'Q'
          return annonce_a_check_with(piece)
        end
      end

    board[king_posy...board.size]
      .map { |line| line[king_posx] }
      .each do |piece|
        case piece
        when 'P', 'B'
          break
        when 'R', 'Q'
          return annonce_a_check_with(piece)
        end
      end

    ### Check the 2 vertical directions (up and down) for R & Q ###
    board[king_posy][0..king_posx].reverse_each do |piece|
      case piece
      when 'P', 'B'
        break
      when 'R', 'Q'
        return annonce_a_check_with(piece)
      end
    end

    board[king_posy][king_posx...board.size].each do |piece|
      case piece
      when 'P', 'B'
        break
      when 'R', 'Q'
        return annonce_a_check_with(piece)
      end
    end

    ### Check the 4 diagonal directions for B & Q ###
    [king_posy, king_posx].then do |y, x|
      while inside_board?(y, x)
        piece = board[y][x]

        case piece
        when 'P', 'R'
          break
        when 'B', 'Q'
          return annonce_a_check_with(piece)
        end

        y -= 1
        x -= 1
      end
    end

    [king_posy, king_posx].then do |y, x|
      while inside_board?(y, x)
        piece = board[y][x]

        case piece
        when 'P', 'R'
          break
        when 'B', 'Q'
          return annonce_a_check_with(piece)
        end

        y -= 1
        x += 1
      end
    end

    [king_posy, king_posx].then do |y, x|
      while inside_board?(y, x)
        piece = board[y][x]

        case piece
        when 'P', 'R'
          break
        when 'B', 'Q'
          return annonce_a_check_with(piece)
        end

        y += 1
        x -= 1
      end
    end

    [king_posy, king_posx].then do |y, x|
      while inside_board?(y, x)
        piece = board[y][x]

        case piece
        when 'P', 'R'
          break
        when 'B', 'Q'
          return annonce_a_check_with(piece)
        end

        y += 1
        x += 1
      end
      "jij"
    end # => [king_posy, king_posx]

    ### Check for P ###
    if inside_board?(king_posy + 1, king_posx + 1) &&
       board[king_posy + 1][king_posx + 1] == 'P'
      return annonce_a_check_with('P')
    end
    if inside_board?(king_posy + 1, king_posx - 1) &&
       @board[king_posy + 1][king_posx - 1] == 'P'
      return annonce_a_check_with('P')
    end

    'The king is not in check.'
  end

  private

  attr_reader :king_posy, :king_posx

  def localize_king
    board.each_with_index do |line, y|
      line.each_with_index do |piece, x|
        next unless piece == 'K'

        @king_posy = y
        @king_posx = x
        break
      end
    end

    return unless king_posx.nil? || king_posy.nil?

    puts 'You must place a king on the map.'
    exit
  end

  def annonce_a_check_with(piece)
    "THE #{PIECE_NAMES[piece].upcase} HAS THE KING IS IN CHECK!"
  end

  def inside_board?(y, x)
    y >= 0 && x >= 0 && y < board.size && x < board.size
  end

  def check_input(board)
    return if board.size > 1

    puts <<~TEXT
      To few arguments
      Rules:
        - Place a king in a square map, and the desired number of pieces, and this script will tell you if the king is in check.

      To create a map:
        - Each argument is a line, the map must be a square, can have only one king and there can be the following pieces:
        #{
          %w[K P Q R B .].map do |piece|
            piece_name = ChessGame::PIECE_NAMES[piece]

            "- '#{piece}'" \
            " for a#{'n' if piece_name.downcase.start_with?('a', 'e', 'i', 'o', 'u', 'y')}" \
            " #{piece_name.split.map(&:capitalize).join(' ')}"
          end.join("\n  ")
        }

      Example, for a 5x5 map (five arguments of five characters each), 5 arguments:
        R..P.
        .....
        QBK.P
        .R...
        .PPB.
      i.e. in CLI: `./chess R..P. '.....' QBK.P .R... .PPB.`
    TEXT
    exit
  end
end

puts self.class

# # PROGRAM
# chess = ChessGame.new(ARGV.map(&:chars))

# puts chess.check
# puts 'Board:', chess.board.map(&:join)

