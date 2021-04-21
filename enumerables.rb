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

    def my_any?
        result=false
        to_a.my_each do |item|
           if yield item 
            result = true
           end
        end
        result
    end

    def my_none?
        result =true
        to_a.my_each do |item|
            if yield item
                result = false   
            end
        end
        result
    end

    def my_count(check = nil) 
    
        maches = 0;
        if check 
            to_a.my_each do |item|
                if item == check
                    maches +=1
                end
            end
    
        elsif block_given? 
            to_a.my_each do |item|
                if yield item
                    maches +=1
                end
            end 
        else
            maches = to_a.length
        end
    
        maches
    end

    def my_map
        new_arr=[]
        to_a.my_each do |item|
            new_arr.push(yield item) 
        end
        new_arr
    end

    def my_inject(acc = nil)
        accumulator = 1
        if acc 
            accumulator = acc
            to_a.my_each do |item|
                accumulator = yield accumulator, item 
            end
        else
            to_a.my_each do |item|
                accumulator = yield accumulator, item 
            end 
        end
        accumulator 
    end
end


def multiply_els(array)
    return array.my_inject do |acc, item| 
        acc * item
    end
end



puts multiply_els([2,4,5])
