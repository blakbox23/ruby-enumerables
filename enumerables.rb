module Enumerable
    def my_each
        for item in to_a
           yield item
        end
    end
end
