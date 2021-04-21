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

    def my_select
        new_array=[]
        to_a.my_each do |item|
            if yield item
                new_array.push(item)
            end
        end
        new_array
    end

    def my_all?
        result=true
        to_a.my_each do |item|
           unless yield item  
            result=false
           end
        end
        result
    end
end

 check = [2,4].my_all? do |item|
    item.even?
   end

puts check
