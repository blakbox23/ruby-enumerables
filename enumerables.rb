module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    to_a.each(&block)
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    (0...to_a.length).each do |index|
      yield to_a[index], index
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    to_a.my_each do |item|
      new_array.push(item) if yield item
    end
    new_array
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    result = true
    to_a.my_each do |item|
      result = false unless yield item
    end
    result
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    result = false
    to_a.my_each do |item|
      result = true if yield item
    end
    result
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    result = true
    to_a.my_each do |item|
      result = false if yield item
    end
    result
  end

  def my_count(check = nil)
    maches = 0
    if check
      to_a.my_each do |item|
        maches += 1 if item == check
      end

    elsif block_given?
      to_a.my_each do |item|
        maches += 1 if yield item
      end
    else
      maches = to_a.length
    end

    maches
  end

  def my_map(proc = nil)
    new_arr = []
    if proc
      to_a.my_each do |item|
        new_arr.push(proc.call(item))
      end
    else
      to_a.my_each do |item|
        new_arr.push(yield item)
      end
    end

    new_arr
  end

  def my_inject(accumulator = nil)
    accumulator = nil unless accumulator.nil?
    to_a.my_each { |item| accumulator = accumulator.nil? ? item : yield(accumulator, item) }
    accumulator
  end
end
