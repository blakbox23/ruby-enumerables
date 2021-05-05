require './enumerables'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:range) { (1..5) }
  let(:test_arr) { [] }
  let(:hash) { { apples: 10, oranges: 5, bananas: 1 } }
  let(:test_hash) { {} }
  let(:arr_char) { %w[ant bear cat] }
  let(:mix_arr) { [1, 2i, 3.14] }
  let(:bool) { [nil, true, 99] }
  let(:nil_arr) { [nil, false] }

  describe '#my_each' do
    context 'If block is not given' do
      it 'returns enumerator if no block is given' do
        expect(arr.my_each).to be_a(Enumerator)
      end
    end

    context 'If block is given' do
      it 'returns an array if block is given' do
        arr.my_each { |i| i * 2 }
        expect(arr.my_each { |i| i * 2 }).to eql(arr)
      end
      it 'Range is used' do
        expect(range.my_each { |i| i * 2 }).to eql(range)
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
        arr.my_each_with_index { |_item, index| test_arr.push(index) }
        expect(test_arr).to eql([0, 1, 2, 3, 4])
      end
      it 'returns the item' do
        arr.my_each_with_index { |item, _index| test_arr.push(item) }
        expect(test_arr).to eql(arr)
      end
    end
  end

  describe '#my_select' do
    context 'If block is not given' do
      it 'returns an enumerable' do
        expect(arr.my_select).to be_a(Enumerator)
      end
    end
    context 'if block is given' do
      it 'returns new array that meets condition' do
        arr.my_select { |item| item.even? ? test_arr << item : nil }
        expect(test_arr).to eql([2, 4])
      end
      it 'returns a new hash that meets the condition' do
        hash.my_select { |k, v| v > 1 ? test_hash[k] = v : nil }
        expect(test_hash).to eql({ apples: 10, oranges: 5 })
      end
      it 'returns new range that meets condition' do
        range.my_select { |item| item.odd? ? test_arr << item : nil }
        expect(test_arr).to eql([1, 3, 5])
      end
    end
  end

  describe '#my_all?' do
    context 'if block is given' do
      it 'returns true if the block doesn\'t return false' do
        expect(arr.my_all? { |i| i > 0 }).to be true
      end

      it 'returns true if the block doesn\'t return false' do
        expect(arr.my_all?(&:even?)).not_to be true
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

  describe '#my_any?' do
    context 'if block is given' do
      it 'returns true if the block ever returns a value other than false or nil' do
        expect(arr_char.my_any? { |word| word.length >= 3 }).to be true
      end

      it 'returns false if the block never returns true' do
        expect(arr_char.my_any? { |word| word.length < 3 }).to be false
      end
    end

    context 'if params is given and no block is given' do
      it 'returns false if any of the elements doesn\'t match the Regex' do
        expect(arr_char.my_any?(/d/)).to be false
      end

      it 'returns true if any of the elements match the Regex' do
        expect(arr_char.my_any?(/r/)).to be true
      end

      it 'returns true if any of the elements belong to the Class' do
        expect(bool.my_any?(Integer)).to be true
      end

      it 'returns false if none of the elements belong to the Class' do
        expect(bool.my_any?(String)).to be false
      end
    end

    context 'if no params or block is given' do
      it 'returns true if there is any instance that is true' do
        expect(bool.my_any?).to be true
      end

      it 'returns false for an empty array' do
        expect(test_arr.my_any?).to be false
      end
    end
  end

  describe '#my_none?' do
    context 'if block is given' do
      it 'returns true if the block never returns true for all elements' do
        expect(arr_char.my_none? { |word| word.length == 5 }).to be true
      end

      it 'returns false if the block returns true' do
        expect(arr_char.my_none? { |word| word.length >= 4 }).to be false
      end
    end

    context 'if params is given and no block is given' do
      it 'returns true if none of the elements match the Regex' do
        expect(arr_char.my_none?(/d/)).to be true
      end

      it 'returns false if any of the elements match the Regex' do
        expect(arr_char.none?(/b/)).to be false
      end

      it 'returns true if none of the elements belong to the Class' do
        expect(bool.my_none?(String)).to be true
      end

      it 'returns false if any of the elements belong to the Class' do
        expect(bool.my_none?(Integer)).to be false
      end
    end

    context 'if no params or block is given' do
      it 'returns true if  the array is empty' do
        expect(test_arr.my_none?).to be true
      end

      it 'return true if the array has no true value' do
        expect(nil_arr.my_none?).to be true
      end

      it 'returns false if any of the elements is true' do
        expect(bool.my_none?).to be false
      end
    end
  end

  describe '#my_count' do
    context 'If block is given' do
      it 'Counts the number of elements yielding a true value' do
        expect(arr.my_count(&:even?)).to eql(2)
      end
    end
    context 'If block is not given' do
      it 'Returns the number of items that are equal to the param' do
        expect(arr.my_count(2)).to eql(1)
      end
      it 'Retruns the size of the array' do
        expect(arr.my_count).to eql(arr.length)
      end
    end
  end

  describe '#my_map' do
    context 'If block is not given' do
      it 'returns an enumerable' do
        expect(arr.my_map).to be_a(Enumerator)
      end
    end
    context 'If block is given' do
      it 'returns a new mutated array' do
        expect(range.my_map { |i| i * i }).to eql([1, 4, 9, 16, 25])
      end
      it 'returns repeated output for the range given' do
        expect(range.my_map { 'cat' }).to eql(%w[cat cat cat cat cat])
      end
    end
  end

  describe '#my_inject' do
    context 'if block is given' do
      it 'returns the accumulated value' do
        expect(range.my_inject { |sum, n| sum + n }).to eql(15)
      end

      it 'returns the longest word' do
        expect(arr_char.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('bear')
      end
    end

    context 'if block is not given' do
      it 'returns accumulated value based on the symbol passed' do
        expect(range.my_inject(:+)).to eql(15)
      end

      it 'returns accumulated value based on the symbol and number passed' do
        expect(range.my_inject(2, :*)).to eql(240)
      end
    end
  end

  describe '#multiply_els' do
    it 'returns the product of the param passed' do
      expect(multiply_els(arr)).to eql(120)
    end
  end
end
