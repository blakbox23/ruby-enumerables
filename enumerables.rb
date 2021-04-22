# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    # rubocop:disable Style/For
    for item in to_a
      yield item
    end
    # rubocop:enable Style/For
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    # rubocop:disable Style/For
    for i in (0...to_a.length)
      yield to_a[i], i
    end
    # rubocop:enable Style/For
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    to_a.my_each do |item|
      new_array.push(item) if yield item
    end
    new_array
  end

  # rubocop:disable Style/CaseEquality
  def my_all?(*params)
    result = true
    if !params[0].nil?
      my_each do |item|
        result = false unless params[0] === item
      end

    elsif !block_given?
      my_each do |item|
        result = false unless item
      end

    else
      my_each do |item|
        result = false unless yield(item)
      end
    end
    result
  end

  def my_any?(*params)
    result = false
    if !params[0].nil?
      my_each do |item|
        result = true if params[0] === item
      end
    elsif !block_given?
      my_each do |item|
        result = true if item
      end
    else
      to_a.my_each do |item|
        result = true if yield item
      end
    end
    result
  end

  def my_none?(*params)
    result = true
    if !params[0].nil?
      my_each do |item|
        result = false if params[0] === item
      end
    elsif !block_given?
      my_each do |item|
        result = false if item
      end
    else
      to_a.my_each do |item|
        result = false if yield item
      end
    end
    result
  end

  # rubocop:enable Style/CaseEquality

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
    # rubocop:disable Lint/ToEnumArguments
    return to_enum(:my_map) unless block_given?
    # rubocop:enable Lint/ToEnumArguments

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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity

  def my_inject(*params)
    arr = to_a
    result = params[0] if params[0].is_a? Integer

    case params[0]
    when Symbol, String
      symbol = params[0]

    when Integer
      symbol = params[1] if params[1].is_a?(Symbol) || params[1].is_a?(String)
    end

    if symbol
      arr.my_each { |item| result = result ? result.send(symbol, item) : item }
    else
      arr.my_each { |item| result = result ? yield(result, item) : item }
    end

    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
# rubocop:enable Metrics/ModuleLength

def multiply_els(arg)
  arg.my_inject { |acc, item| acc * item }
end