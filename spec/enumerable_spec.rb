require "rspec"
require_relative "../enumerables.rb"

# a = [ "a", "b", "c" ]
# a.each {|x| print x, " -- " }
describe Enumerable do 
    let(:arr) {[1,2,3,4,5]}
    let(:hash) {{'dog' => 'canine', 'cat' => 'feline', 'donkey' => 'asinine', 12 => 'dodecine'}}
    let(:range) {(3..8)}
    describe "#my_each" do 
        let(:output) {[]}
        context "If we pass a block while calling the method" do 
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
    end
end