class Board
    attr_reader :cells

    def initialize
        @cells = create_board
    end

    def create_board
        hash = {}
        for i in ("1".."4") do
            for l in ("A".."D") do
                hash[l + i] = Cell.new(l + i)
            end
        end
        hash
    end

    def place(ship, coords)
        coords.each { |coord| cells[coord].place_ship(ship) }
    end

    def valid_coordinate?(coord)
        cells.key?(coord) ? true : false
    end

    def valid_placement?(ship, coords)
        if ship.length != coords.length || coords.sort != coords
            return false
        elsif occupied?(coords)
            return false
        elsif valid_orientation?(coords)
            return true
        else
            return false
        end
    end

    def occupied?(coords)
        coords.any? { |coord| !cells[coord].empty? }
    end

    def valid_orientation?(coords)
        arrangement = find_arrangement(coords)

        coords.each_cons(2) do |coord|
            if arrangement == :row
                return false if coord[0][1].to_i + 1 != coord[1][1].to_i
            elsif arrangement == :column
                return false if coord[0][0].ord + 1 != coord[1][0].ord
            else
                return false
            end
        end
        return true
    end

    def find_arrangement(coords)
        return :row if coords.all? { |coord| coord[0] == coords[0][0] }
        return :column if coords.all? { |coord| coord[1] == coords[0][1] }
        return :diagnol
    end

    def render(show_ship = false)
        puts "  1 2 3 4 "
        group_rows.each { |letter, cells| render_row(letter, cells, show_ship) }
    end

    def group_rows
        cells.values.group_by { |cell| cell.coordinate[0] }
    end

    def render_row(letter, cells, show_ship)
        row = "#{letter} "
        cells.each { |cell| row += cell.render(show_ship) + " " }
        puts row
    end
end
