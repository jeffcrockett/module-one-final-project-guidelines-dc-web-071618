describe ".all" do 
    it "is an ActiveRecord_relation" do 
        expect(Stadium.all).to be_an_instance_of(Stadium::ActiveRecord_Relation)
    end
end

describe 