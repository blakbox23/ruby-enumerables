require "rspec"
require_relative "../enumerables.rb"

# a = [ "a", "b", "c" ]
# a.each {|x| print x, " -- " }
describe Enumerable do 
    let(:arr) {[1,2,3,4,5]}
    describe "#my_each" do 
        let(:output) {[]}
        context "If we pass a block while calling the method" do 
            it "loop throuth the collection and output individual item" do 
                arr.my_each {|item| output << item}
                expect(output).to eql(arr)
            end
        end
    end
end