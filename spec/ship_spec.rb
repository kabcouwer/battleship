require_relative 'spec_helper'

RSpec.describe Ship do
    before :each do
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe 'instantiation' do
        it 'exists' do
            expect(@cruiser).to be_a(Ship)
        end

        it 'has readable attributes' do
            expect(@cruiser.name).to eq("Cruiser")
            expect(@cruiser.length).to eq(3)
            expect(@cruiser.health).to eq(3)
        end
    end

    describe '#sunk?' do
        it 'can output if a ship has been sunk or not' do
            expect(@cruiser.sunk?).to eq(false)
        end
    end

    describe '#hit' do
        it 'can remove 1 health unit if ship is hit' do
            @cruiser.hit
            expect(@cruiser.health).to eq(2)
            expect(@cruiser.sunk?).to eq(false)

            @cruiser.hit
            expect(@cruiser.health).to eq(1)
            expect(@cruiser.sunk?).to eq(false)

            @cruiser.hit
            expect(@cruiser.health).to eq(0)
            expect(@cruiser.sunk?).to eq(true)
        end
    end
end
