class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        ship == nil ? true : false
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        @fired_upon = true
        ship.hit if ship != nil
    end

    def render(show_ship = false)
        if ship && ship.sunk?
            return "X"
        elsif fired_upon? && empty?
            return "M"
        elsif fired_upon? && !empty?
            return "H"
        elsif !fired_upon? && !empty? && show_ship
            return "S"
        else
            return "."
        end
    end
end
