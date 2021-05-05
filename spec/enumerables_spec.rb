require './enumerables.rb'

describe Enumerable do
  let(:arr) {[1, 2, 3, 4, 5]}
  let(:range) {(1..5)}
  let(:test_arr) {[]}
  let(:hash) {{apples: 10, oranges: 5, bananas: 1}}
  let(:test_hash) {{}}
  let(:arr_char) {%w[ant bear cat]}
  let(:mix_arr) {[1, 2i, 3.14]}
  let(:bool) {[nil, true, 99]}

  describe '#my_each' do

  context 'If block is not given' do
    it 'returns enumerator if no block is given' do
      expect(arr.my_each).to be_a(Enumerator)
    end
  end

  context 'If block is given' do
      it 'returns an array if block is given' do
        arr.my_each{ |i| i * 2 }
        expect(arr.my_each{ |i| i * 2 }).to eql(arr)
      end
      it 'Range is used'do
        expect(range.my_each{ |i| i*2 }).to eql(range)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is not given' do
      it 'returns enumerator if no block is given' do
        expect(arr.my_each_with_index).to be_a(Enumerator)
      end
    end
    context 'If block is given' do
      it 'returns the index' do
        arr.my_each_with_index{|item, index| test_arr.push(index)}
        expect(test_arr).to eql([0,1,2,3,4])
      end
      it 'returns the item' do
        arr.my_each_with_index{|item, index| test_arr.push(item)}
        expect(test_arr).to eql(arr)
      end
    end
  end

    describe '#my_select' do
      context 'If block is not given'do
        it 'returns an enumerable'do
        expect(arr.my_select).to be_a(Enumerator)
        end
      end
      context 'if block is given' do
        it 'returns new array that meets condition' do
          arr.my_select{|item|  item.even? ? test_arr << item : nil }
          expect(test_arr).to eql([2,4])
        end
        it 'returns a new hash that meets the condition' do
          hash.my_select{|k, v| v > 1 ? test_hash[k] = v : nil}
          expect(test_hash).to eql({apples: 10, oranges: 5})
        end
        it 'returns new range that meets condition' do
          range.my_select{|item|  item.odd? ? test_arr << item : nil }
          expect(test_arr).to eql([1,3,5])
        end
      end
    end

    describe '#my_all?' do
      context 'if block is given' do
        it 'returns true if the block doesn\'t return false' do
          expect(arr.my_all? {|i| i > 0}).to be true
        end

        it 'returns true if the block doesn\'t return false' do
          expect(arr.my_all? {|i| i.even?}).not_to be true
        end
      end

      context 'if params is given and no block is given' do
        it 'returns false if all elements don\'t match Regex' do
          expect(arr_char.my_all?(/t/)).to be false
        end

        it 'returns true if all elements match Regex' do
          expect(arr_char.my_all?(/a/)).to be true
        end

        it 'returns true if all elements belong to the Class' do
          expect(mix_arr.my_all?(Numeric)).to be true
        end

        it 'returns false if all elements don\'t belong to the Class' do
          expect(mix_arr.my_all?(String)).to be false
        end
      end

      context 'if no params or block is given' do
        it 'returns false if there is an instance that is false or nil' do
          expect(bool.my_all?).to be false
        end

        it 'returns true if all instances are true' do
          expect(arr.my_all?).to be true
        end

        it 'returns true for an empty array' do
          expect(test_arr.my_all?).to be true
        end
      end
    end
 
end
