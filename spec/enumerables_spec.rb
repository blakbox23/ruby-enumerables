require './enumerables.rb'

describe Enumerable do
  let(:arr) {[1, 2, 3, 4, 5]}
  let(:range) {(0..5)}
  let(:test_arr) {[]}


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
end