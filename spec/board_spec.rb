require_relative 'spec_helper'

RSpec.describe Board do
    before :each do
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
    end

    describe "instantiation" do
        it "exists" do
            expect(@board).to be_a(Board)
        end

        it "has readable attributes" do
            expect(@board.cells).to be_a(Hash)
            expect(@board.cells["A1"]).to be_a(Cell)
            expect(@board.cells["A1"].coordinate).to eq("A1")
            expect(@board.cells["B4"]).to be_a(Cell)
            expect(@board.cells["B4"].coordinate).to eq("B4")
            expect(@board.cells["C2"]).to be_a(Cell)
            expect(@board.cells["C2"].coordinate).to eq("C2")
            expect(@board.cells["D3"]).to be_a(Cell)
            expect(@board.cells["D3"].coordinate).to eq("D3")
        end
    end

    describe "#valid_coordinate?" do
        it "can validate that a coordinate is on the board" do
            expect(@board.valid_coordinate?("A1")).to eq(true)
            expect(@board.valid_coordinate?("D4")).to eq(true)
            expect(@board.valid_coordinate?("A5")).to eq(false)
            expect(@board.valid_coordinate?("E1")).to eq(false)
            expect(@board.valid_coordinate?("A22")).to eq(false)
        end
    end

    describe "#place" do
        it 'can place a ship in its cells' do
            @board.place(@cruiser, ["A1", "A2", "A3"])    
            cell_1 = @board.cells["A1"]    
            cell_2 = @board.cells["A2"]
            cell_3 = @board.cells["A3"]

            expect(cell_1.ship == cell_2.ship).to eq(true)
            expect(cell_2.ship == cell_3.ship).to eq(true)
        end
    end

    describe "#valid_placement?" do
        it "can check if the number of coordinates equals the ship length" do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
        end

        it "can check that the coordinates are consecutive" do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["B1", "C1"])).to eq(true)
        end

        it "can check that coordinates are not diagonal" do
            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "B2"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A2", "B2", "C2"])).to eq(true)
            expect(@board.valid_placement?(@cruiser, ["D2", "D3", "D4"])).to eq(true)
        end

        it "can check if coordinates are already occupied by another ship" do
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
        end
    end

    describe "#render" do
        it "can render the game board" do
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect { @board.render }.to output("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n").to_stdout
            expect { @board.render(true) }.to output("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n").to_stdout
        end
    end
end
