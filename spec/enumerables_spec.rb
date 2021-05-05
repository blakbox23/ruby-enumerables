require './enumerables.rb'

describe Enumerable do
  let(:arr) {[1, 2, 3, 4, 5]}

  describe '#my_each' do
    it 'returns enumerator if no block is given' do
      expect(arr.my_each).to be_a(Enumerator)
    end

    it 'returns an array if block is given' do
      expect(arr.my_each{ |i| i * 2 }).to eq(arr)
    end
  end
end