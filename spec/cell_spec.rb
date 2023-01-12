require_relative 'spec_helper'

RSpec.describe Cell do
    before :each do
        @cell_1 = Cell.new("B4")
        @cruiser = Ship.new("Cruiser", 3)
        @cell_2 = Cell.new("C3")
    end

    describe "instantiation" do
        it "exists" do
            expect(@cell_1).to be_a(Cell)
        end

        it "has readable attributes" do
            expect(@cell_1.coordinate).to eq("B4")
            expect(@cell_1.ship).to eq(nil)
        end
    end

    describe "#empty?" do
        it "returns output for if cell contains a ship or not" do
            expect(@cell_1.empty?).to eq(true)
        end
    end

    describe "#place_ship" do
        it "can place a ship in a cell" do
            @cell_1.place_ship(@cruiser)

            expect(@cell_1.ship).to eq(@cruiser)
            expect(@cell_1.empty?).to eq(false)
        end
    end

    describe "#fired_upon?" do
        it "returns output if cell has been fired upon" do
            expect(@cell_1.fired_upon?).to eq(false)
        end
    end

    describe "#fire_upon" do
        it "can fire upon a cell and update the health of its ship" do
            @cell_1.place_ship(@cruiser)
            @cell_1.fire_upon

            expect(@cell_1.fired_upon?).to eq(true)
            expect(@cell_1.ship.health).to eq(2)
        end
    end

    describe "#render" do
        it "can render a '.' if the cell has not been fired upon" do
            expect(@cell_1.render).to eq(".")
        end

        it "can render an 'M' if the cell has not been fired upon and empty" do
            @cell_1.fire_upon
            expect(@cell_1.render).to eq("M")
        end

        it "can render a '.' if the cell has not been fired upon, a ship is there, and don't show ship" do
            @cell_2.place_ship(@cruiser)
            expect(@cell_2.render).to eq(".")
        end

        it "can render a 'S' if the cell has not been fired upon, a ship is there, and show ship" do
            @cell_2.place_ship(@cruiser)
            expect(@cell_2.render(true)).to eq("S")
        end

        it "can render a 'H' if the cell has been fired upon and a ship is there" do
            @cell_2.place_ship(@cruiser)
            @cell_2.fire_upon

            expect(@cell_2.render).to eq("H")
            expect(@cruiser.sunk?).to eq(false)
        end

        it "can render an 'X' if ship has been sunk" do
            @cell_2.place_ship(@cruiser)
            @cell_2.fire_upon
            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.sunk?).to eq(true)
            expect(@cell_2.render).to eq("X")
        end
    end
end
