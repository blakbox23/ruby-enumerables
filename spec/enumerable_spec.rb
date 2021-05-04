require "rspec"
require_relative "../enumerables.rb"

# a = [ "a", "b", "c" ]
# a.each {|x| print x, " -- " }
describe Enumerable do 
    let(:arr) {[1,2,3,4,5]}
    let(:textarr) {["ant", "bear", "cat"]}
    let(:hash) {{'dog' => 'canine', 'cat' => 'feline', 'donkey' => 'asinine', 12 => 'dodecine'}}
    let(:range) {(3..8)}
    describe "#my_each" do 
        let(:output) {[]}
        context "If we pass a block while calling the method on array" do 
            it "loop throuth the collection and output individual item" do 
                arr.my_each {|item| output << item}
                expect(output).to eql(arr)
            end
        end
        context "if we calling my_each on hash" do
            let(:outhash) {Hash.new}
            it "iterates trough the hash key/value pairs" do
                hash.my_each {|key,value| outhash[key] = value}
                expect(outhash).to eql (hash)
            end
        end
        context "if we are calling my_each on range" do
            let(:outrange) {Array.new}
            it "iterates trough the range " do
                range.my_each {|item| outrange << item}
                expect(outrange).to eql(range.to_a)
            end
        end
        context "if we don't pass a block while calling the method" do
            it "return enumerate my_each" do
                expect(arr.my_each).to be_an Enumerator
            end
        end
    end

    describe "#my_each_with_index " do
        let(:output) {[]}
        context "If we pass a block while calling the method on array" do 
            it "loop throuth the collection and output individual item" do 
                arr.my_each_with_index {|item, index| output << item}
                expect(output[3]).to eql(arr[3])
            end
        end
        context "if we are calling my_each_with_index on range" do
            let(:outrange) {Array.new}
            it "iterates trough the range " do
                range.my_each_with_index {|item| outrange << item}
                expect(outrange[1]).to eql(range.to_a[1])
            end
        end
        context "if we don't pass a block while calling the method" do
            it "return enumerate my_each_with_index" do
                expect(arr.my_each_with_index).to be_an Enumerator
            end
        end
    end

    describe "#my_select" do 
        context "When we call the my_select without a block" do 
            it "returns an Enumerator class" do 
                expect(arr.my_select).to be_an Enumerator
            end
        end

        context "When we call my_select with a block" do 
            it "Returns a new array of elements that match the condition inside the block" do 
                result = arr.my_select { |item| item > 2}
                expect(result).to eql([3,4,5])
            end
        end

        context "When we call my_select on a range" do 
            it "Returns a new array of elements that match the condition inside the block" do 
                result = range.my_select { |item| item > 4}
                expect(result).to eql([5,6,7,8])
            end
        end
    end

    describe "#my_all" do
        context "When we pass a block while calling a method and don't have an argument" do
            it "return true if block condition is true for the all elements" do
                expect(arr.my_all?{|n| n < 10}).to be true
            end
            it "return false if block condition is false for the all elements" do
                expect(arr.my_all?{|n| n > 10}).to be false
            end
        end
        context "When we pass an argument without a block " do 
            context "When we have Regexp as argument" do
                it "return false if all elements doesn't match to Regexp" do
                    expect(textarr.my_all?(/t/)).to be false
                end
                it "return true if all elements match to Regexp" do
                    expect(textarr.my_all?(/a/)).to be true
                end
            end
            context "When we have Class as argument" do
                it "return false if all elements are not class instances" do
                    expect(textarr.my_all?(Numeric)).to be false
                end
                it "return true if all elements are class instances" do
                    expect(textarr.my_all?(String)).to be true
                end
            end
        end
        context "When we don't pass any parrameter nor block " do 
            context "When we have array collection " do
                it "return false if any element is nil or false" do
                    expect([nil, true, 99].my_all?).to be false
                end
                it "return true if all elements are true" do
                    expect(["nil", true, 99].my_all?).to be true
                end
            end
            context "When we have empty collection" do
                it "return true " do
                    expect([].my_all?).to be true
                end
            end
        end
    end

end