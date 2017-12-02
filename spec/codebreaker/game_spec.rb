require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    describe '#start' do
      it 'generates secret code' do
        game = Game.new
        game.start
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        game = Game.new
        game.start
        expect(game.instance_variable_get(:@secret_code).length).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 6' do
        game = Game.new
        game.start
        expect(game.instance_variable_get(:@secret_code)).to all( (be >= 1).and be <= 7 )
      end
    end

    context '#mark simple' do
      before(:each) do
        @game = Game.new
        @game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
      end

      it 'codebreaker wins' do
        expect(@game.send(:mark, [1, 2, 3, 4])).to eq(['+', '+', '+', '+'])
      end

      it 'codebreaker guess numbers but not order' do
        expect(@game.send(:mark, [4, 3, 2, 1])).to eq(['-', '-', '-','-'])
      end

      it 'codebreaker guess 3 numbers and them order' do
        expect(@game.send(:mark, [1, 2, 5, 4])).to eq(['+', '+', '+'])
      end

      it 'codebreaker did not guess anything' do
        expect(@game.send(:mark, [5, 5, 5, 5])).to eq([])
      end

      it 'codebreaker input all the same' do
        expect(@game.send(:mark, [3, 3, 3, 3])).to eq(['+'])
      end

      it 'codebreaker input few same numbers but in wrong place' do
        expect(@game.send(:mark, [2, 5, 2, 6])).to eq(['-'])
      end
    end

    context '#mark special' do
      before(:each) do
        @game = Game.new
      end

      it 'codebreaker' do
        @game.instance_variable_set(:@secret_code, [1, 3, 3, 4])
        expect(@game.send(:mark, [5, 6, 3, 6])).to eq(['+'])
      end
    end
  end
end
