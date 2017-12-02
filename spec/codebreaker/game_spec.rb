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
        expect(game.instance_variable_get(:@secret_code)).to all((be >= 1).and(be <= 7))
      end
    end

    describe '#count_pluses' do
      before(:each) do
        @game = Game.new
        @game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
      end

      it 'codebreaker wins' do
        expect(@game.send(:count_pluses, [1, 2, 3, 4])[0]).to eq(4)
      end

      it 'codebreaker guess 3 numbers and them order' do
        expect(@game.send(:count_pluses, [1, 2, 5, 4])[0]).to eq(3)
      end

      it 'codebreaker did not guess anything' do
        expect(@game.send(:count_pluses, [5, 5, 5, 5])[0]).to eq(0)
      end

      it 'codebreaker input all the same' do
        expect(@game.send(:count_pluses, [3, 3, 3, 3])[0]).to eq(1)
      end

      it 'codebreaker guess 1 from 2 same' do
        @game.instance_variable_set(:@secret_code, [1, 3, 3, 4])
        expect(@game.send(:count_pluses, [5, 6, 3, 6])[0]).to eq(1)
      end

    end

    describe '#count_minuses' do
      context 'usual situations' do
        before(:each) do
          @game = Game.new
          @secret_code = [1, 2, 3, 4]
        end

        it 'codebreaker guess numbers but not order' do
          expect(@game.send(:count_minuses, [4, 3, 2, 1], @secret_code)).to eq(4)
        end

        it 'codebreaker guess 1 number but not order' do
          expect(@game.send(:count_minuses, [4, 5, 6, 5], @secret_code)).to eq(1)
        end

        it 'codebreaker input few same numbers guess 1 but in wrong places' do
          expect(@game.send(:count_minuses, [2, 5, 2, 6], @secret_code)).to eq(1)
        end
      end

      context 'special situations' do
        before(:each) do
          @game = Game.new
        end

        it 'codebreaker guess 2 same numbers but in wrong places' do
          expect(@game.send(:count_minuses, [2, 5, 2, 5], [1, 2, 3, 2])).to eq(2)
        end
      end
    end

    describe '#mark' do
      before(:each) do
        @game = Game.new
      end

      it 'codebreaker guess 4 cow and 0 bulls' do
        @game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect(@game.send(:mark, [1, 2, 3, 4])).to eq([4, 0])
      end

      it 'codebreaker guess 1 cow and 2 bulls' do
        @game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect(@game.send(:mark, [1, 4, 2, 5])).to eq([1, 2])
      end

      it 'codebreaker guess 0 cow and 2 bulls' do
        @game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect(@game.send(:mark, [3, 6, 1, 5])).to eq([0, 2])
      end

      it 'codebreaker guess 0 cow and 0 bulls' do
        @game.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect(@game.send(:mark, [5, 5, 6, 6])).to eq([0, 0])
      end

    end
  end
end
