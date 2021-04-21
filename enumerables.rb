module Enumerable
    def my_each
        for item in to_a
           yield item
        end
    end

    def my_each_with_index
        for index in (0...to_a.length)
            yield to_a[index], index
        end
    end
end

[1,2,3,4,5].my_each_with_index do |item, index|
    puts "#{item} is index #{index}"
end