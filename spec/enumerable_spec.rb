require 'rspec'
require_relative '../enumerables'

# a = [ "a", "b", "c" ]
# a.each {|x| print x, " -- " }
describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:textarr) { %w[ant bear cat] }
  let(:hash) { { 'dog' => 'canine', 'cat' => 'feline', 'donkey' => 'asinine', 12 => 'dodecine' } }
  let(:range) { (3..8) }
  describe '#my_each' do
    let(:output) { [] }
    context 'If we pass a block while calling the method on array' do
      it 'loop throuth the collection and output individual item' do
        arr.my_each { |item| output << item }
        expect(output).to eql(arr)
      end
    end
    context 'if we calling my_each on hash' do
      let(:outhash) { {} }
      it 'iterates trough the hash key/value pairs' do
        hash.my_each { |key, value| outhash[key] = value }
        expect(outhash).to eql(hash)
      end
    end
    context 'if we are calling my_each on range' do
      let(:outrange) { [] }
      it 'iterates trough the range ' do
        range.my_each { |item| outrange << item }
        expect(outrange).to eql(range.to_a)
      end
    end
    context "if we don't pass a block while calling the method" do
      it 'return enumerate my_each' do
        expect(arr.my_each).to be_an Enumerator
      end
    end
  end

  describe '#my_each_with_index ' do
    let(:output) { [] }
    context 'If we pass a block while calling the method on array' do
      it 'loop throuth the collection and output individual item' do
        arr.my_each_with_index { |item, _index| output << item }
        expect(output[3]).to eql(arr[3])
      end
    end
    context 'if we are calling my_each_with_index on range' do
      let(:outrange) { [] }
      it 'iterates trough the range ' do
        range.my_each_with_index { |item| outrange << item }
        expect(outrange[1]).to eql(range.to_a[1])
      end
    end
    context "if we don't pass a block while calling the method" do
      it 'return enumerate my_each_with_index' do
        expect(arr.my_each_with_index).to be_an Enumerator
      end
    end
  end

  describe '#my_select' do
    context 'When we call the my_select without a block' do
      it 'returns an Enumerator class' do
        expect(arr.my_select).to be_an Enumerator
      end
    end

    context 'When we call my_select with a block' do
      it 'Returns a new array of elements that match the condition inside the block' do
        result = arr.my_select { |item| item > 2 }
        expect(result).to eql([3, 4, 5])
      end
    end

    context 'When we call my_select on a range' do
      it 'Returns a new array of elements that match the condition inside the block' do
        result = range.my_select { |item| item > 4 }
        expect(result).to eql([5, 6, 7, 8])
      end
    end
  end

  describe '#my_all?' do
    context "When we pass a block while calling a method and don't have an argument" do
      it 'return true if block condition is true for the all elements' do
        expect(arr.my_all? { |n| n < 10 }).to be true
      end
      it 'return false if block condition is false for the all elements' do
        expect(arr.my_all? { |n| n > 10 }).to be false
      end
    end

    context 'When we pass an argument without a block ' do
      context 'When we have Regexp as argument' do
        it "return false if all elements doesn't match to Regexp" do
          expect(textarr.my_all?(/t/)).to be false
        end
        it 'return true if all elements match to Regexp' do
          expect(textarr.my_all?(/a/)).to be true
        end
      end
      context 'When we have Class as argument' do
        it 'return false if all elements are not class instances' do
          expect(textarr.my_all?(Numeric)).to be false
        end
        it 'return true if all elements are class instances' do
          expect(textarr.my_all?(String)).to be true
        end
      end
    end
    context "When we don't pass any parrameter nor block " do
      context 'When we have array collection ' do
        it 'return false if any element is nil or false' do
          expect([nil, true, 99].my_all?).to be false
        end
        it 'return true if all elements are true' do
          expect(['nil', true, 99].my_all?).to be true
        end
      end
      context 'When we have empty collection' do
        it 'return true ' do
          expect([].my_all?).to be true
        end
      end
    end
  end

  describe '#my_any?' do
    context "When we pass a block while calling a method and don't have an argument" do
      it 'return true if at least one element matches the condition in the block' do
        expect(arr.my_any? { |n| n > 4 }).to be true
      end
      it 'return false if none element matches the condition in the block' do
        expect(arr.my_any? { |n| n > 10 }).to be false
      end
    end
    context 'When we pass an argument without a block ' do
      context 'When we have Regexp as argument' do
        it "return false if all elements don't match to Regexp" do
          expect(textarr.my_any?(/x/)).to be false
        end
        it 'return true if at least one element matches the condition' do
          expect(textarr.my_any?(/t/)).to be true
        end
      end
      context 'When we have Class as argument' do
        it 'return false if all elements are not class instances' do
          expect(textarr.my_any?(Numeric)).to be false
        end
        it 'return true if at least one element is class instance' do
          expect([1, 'l', 20].my_any?(String)).to be true
        end
      end
    end
    context "When we don't pass any parrameter nor block " do
      context 'When we have array collection ' do
        it 'return false if any element is nil or false' do
          expect([nil, false, false].my_any?).to be false
        end
        it 'return true if at least one element is true' do
          expect([nil, true, false].my_any?).to be true
        end
      end
      context 'When we have empty collection' do
        it 'return false ' do
          expect([].my_any?).to be false
        end
      end
    end
  end

  describe '#my_none?' do
    context "When we pass a block while calling a method and don't have an argument" do
      it 'return true if none of elements matches the condition in the block' do
        expect(arr.my_none? { |n| n > 8 }).to be true
      end
      it 'return false if at least one element matches the condition in the block' do
        expect(arr.my_none? { |n| n > 4 }).to be false
      end
    end
    context 'When we pass an argument without a block ' do
      context 'When we have Regexp as argument' do
        it 'return false if any element match to Regexp' do
          expect(textarr.my_none?(/t/)).to be false
        end
        it "return true if all element don't matches the condition" do
          expect(textarr.my_none?(/x/)).to be true
        end
      end
      context 'When we have Class as argument' do
        it 'return false if any elemnent is class instance' do
          expect([2, 4, 5, 'word'].my_none?(String)).to be false
        end
        it 'return true if all elements are not class instance' do
          expect(arr.my_none?(String)).to be true
        end
      end
    end
    context "When we don't pass any parrameter nor block " do
      context 'When we have array collection ' do
        it 'return false if at least one element is true ' do
          expect([nil, false, true].my_none?).to be false
        end
        it 'return true if all elements are nil or false' do
          expect([nil, false, false].my_none?).to be true
        end
      end
      context 'When we have empty collection' do
        it 'return true ' do
          expect([].my_none?).to be true
        end
      end
    end
  end

  describe '#my_count' do
    context 'When a block is passed while calling the method' do
      it 'return the number of elements that match the condition in the block' do
        result = arr.my_count { |item| item > 3 }
        expect(result).to eql(2)
      end
    end

    context 'When an argument is passed without a block' do
      it 'return the number of elements that match the argument' do
        result = arr.my_count(2)
        expect(result).to eql(1)
      end
    end

    context 'When no block neither argument is passed' do
      it 'return the number of all the elements in the collection' do
        result = arr.my_count
        expect(result).to eql(5)
      end
    end

    context 'When we compare elements of the collection which are numbers to a string' do
      it 'Raise error' do
        expect { arr.my_count { |item| item > '3' } }.to raise_error(StandardError)
      end
    end
  end

  describe '#my_map' do
    context 'When we pass block without arguments' do
      it 'Return new array with new elements' do
        expect(arr.my_map { |i| i * i }).to eql([1, 4, 9, 16, 25])
      end
      context 'When we pass block without operations ' do
        it 'return block value for each element in array' do
          expect(arr.my_map { 'cat' }).to eql(%w[cat cat cat cat cat])
        end
      end
    end
    context 'When we pass block with proc' do
      my_proc = proc { |i| i * 2 }
      it 'Return new array and execute only proc' do
        expect((1..5).my_map(my_proc) { |i| i * i }).to eql([2, 4, 6, 8, 10])
      end
    end
    context "When we don't pass block" do
      it 'Returns enumerator' do
        expect(arr.my_map).to be_an Enumerator
      end
    end

    context 'When we pass block with math operation on intergers and strings' do
      it 'Raise an error' do
        expect { [1, '2', 5].my_map { |item| item * item } }.to raise_error(StandardError)
      end
    end
  end

  describe '#my_inject' do
    context 'When a symbol is passed as an argument without a block' do
      it 'Returns the result from the operation with the symbol' do
        expect(arr.my_inject(:+)).to eql(15)
      end
    end

    context 'When a block is passed without argument' do
      it 'Returns the result from the operation inside the block' do
        expect(arr.my_inject { |a, b| a + b }).to eql(15)
      end
    end

    context 'When a symbol and default value are passed as arguments without a block' do
      it 'Returns the result from the operation with the symbol with accumulator as the first item' do
        expect(arr.my_inject(5, :+)).to eql(20)
      end
    end

    context 'When a default value is passed as arguments with a block' do
      it 'Returns the result from the operation inside the block with accumulator as the first item' do
        expect(arr.my_inject(5) { |a, b| a + b }).to eql(20)
      end
    end

    context 'When the argument is a string and we use it for math operations with integers' do
      it 'Raise an error' do
        expect { arr.my_inject('5') { |a, b| a * b } }.to raise_error(StandardError)
      end
    end

    context 'When the argument is a string and we use it for math operations with integers' do
      it 'Raise an error' do
        expect { arr.my_inject }.to raise_error(StandardError)
      end
    end
  end
end

describe '#multiply_els' do
  context 'When we pass an array as argument to the method' do
    it 'returns a value as result of the multiplication inside the block' do
      expect(multiply_els([1, 2, 3, 4, 5])).to eql(120)
    end
  end

  context "When we don't pass an argument to the method" do
    it 'Raise an error' do
      expect { multiply_els }.to raise_error(StandardError)
    end
  end
end
