#!usr/bin/env ruby

if (ARGV.length > 1)
    class ChessGame
        attr_accessor :board
        attr_accessor :posy
        attr_accessor :posx
        def initialize
            @board = Array.new(ARGV.length) { Array.new(ARGV.length) }
        end

        / CREATION DE LA MAP /
        def fill_board
            i = 0
            while i < ARGV.length do
                @board[i] = ARGV[i]
                i += 1
            end
        end
       
        / RECHERCHE POSITION DU ROI /
        def find_king
            y = 0
            while y < ARGV.length do
                x = 0
                while x < ARGV.length do
                    if @board[y][x] == "K"
                        @posy = y
                        @posx = x
                        return
                    end
                    x += 1
                end
                y += 1
            end
            if !posx && !posy
                print "You must place a king on the map", "\n"
                exit (true)
            end
        end

        / ALGO VERIFICATION SI ROI EN ECHEC /
        def check

            / AFFICHAGE DE LA MAP /
            def print_map
                i = 0
                print "Map:", "\n"
                while i < ARGV.length do
                    print @board[i], "\n"
                    i += 1
                end
            end

            y = posy
            x = posx
            while y >= 0 do
                if @board[y][x] == "P" || @board[y][x] == "B"
                    break 
                elsif @board[y][x] == "R" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                y -= 1
            end

            y = posy
            while y < ARGV.length do
                if @board[y][x] == "P" || @board[y][x] == "B"
                    break
                elsif @board[y][x] == "R" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                y += 1
            end

            y = posy
            while x >= 0 do
                if @board[y][x] == "P" || @board[y][x] == "B"
                    break
                elsif @board[y][x] == "R" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                x -= 1
            end

            x = posx
            while x < ARGV.length do
                if @board[y][x] == "P" || @board[y][x] == "B"
                    break
                elsif @board[y][x] == "R" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                x += 1
            end

            y = posy
            x = posx
            while y >= 0 && x >= 0 do
                if @board[y][x] == "P" || @board[y][x] == "R"
                    break
                elsif @board[y][x] == "B" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                y -= 1
                x -= 1
            end

            y = posy
            x = posx
            while y >= 0 && x < ARGV.length do
                if @board[y][x] == "P" || @board[y][x] == "R"
                    break
                elsif @board[y][x] == "B" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                y -= 1
                x += 1
            end

            y = posy
            x = posx
            while y < ARGV.length && x >= 0 do
                if @board[y][x] == "P" || @board[y][x] == "R"
                    break
                elsif @board[y][x] == "B" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                y += 1
                x -= 1
            end

            y = posy
            x = posx
            while y < ARGV.length && x < ARGV.length do
                if @board[y][x] == "P" || @board[y][x] == "R"
                    break
                elsif @board[y][x] == "B" || @board[y][x] == "Q"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
                y += 1
                x += 1
            end

            if posy + 1 < ARGV.length && posx + 1 < ARGV.length
                if @board[posy + 1][posx + 1] == "P"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
            end
            if posy + 1 < ARGV.length && posx - 1 >= 0
                if @board[posy + 1][posx - 1] == "P"
                    return (print "THE KING IS IN CHECK !", "\n")
                end
            end
            print "The king is not in check.", "\n"
        end
    end
    chess = ChessGame.new
    chess.fill_board
    chess.find_king
    chess.check
    chess.print_map

/ NOMBRE D'ARGUMENTS NON VALIDE /
else
    print "To few arguments","\n"
    / CREATION MAP ET REGLES /
    def how_to_create_map
        puts "Rules: Place a king in a square map, and the desired number of pieces, and this script will tell you if the king is in check."
        puts "To create a map:
        - Each argument is a line, the map must be a square, can have only one king and there can be the following pieces:
        - 'K' for a king
        - 'P' for pawn
        - 'Q' for a queen
        - 'R' for rook
        - 'B' for bishop
        - '.' for the empty boxes
        Example, for a 5x5 map (five arguments of five characters each):
        First argument:  R..P.
        Second argument: .....
        Third argument:  QBK.P
        Fourth argument: .R...
        Fifth argument:  .PPB."
    end
    how_to_create_map
end
