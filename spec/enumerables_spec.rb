require './enumerables.rb'

describe Enumerable do
  let(:arr) {[1, 2, 3, 4, 5]}
  let(:range) {(1..5)}
  let(:test_arr) {[]}
  let(:hash) {{
    apples: 10,
    oranges: 5,
    bananas: 1
  }}

  let(:test_hash) {{}}
 

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

  
   
  
 
end