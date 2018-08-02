# require 'RSpec'

describe '#initialize' do 
    it 'should create a new team' do
      new_team = Team.new(name: "New Team")
      expect(new_team.name).to eq("New Team")
    end
  end
    # it "has an id" do 
    #   new_team = Team.create(name: "Team With Stadium")
    #   expect(new_team.id).not_to be_nil
    # end
    describe "#home_team_matches" do 
      it "returns an array of Match objects" do
        matches = Team.find(10).home_team_matches 
        expect(matches).to be_an_instance_of(Match::ActiveRecord_Relation)
      end

      it "has 19 home matches" do 
        matches = Team.find(12).home_team_matches 
        expect(matches.length).to be(19)
      end
  end

  describe "#away_team_matches" do 
    it "returns an array of Match objects" do
      matches = Team.find(10).away_team_matches 
      expect(matches).to be_an_instance_of(Match::ActiveRecord_Relation)
    end

    it "has 19 matches" do 
      matches = Team.find(12).away_team_matches 
      expect(matches.length).to be(19)

    end
end

  describe "#all_matches" do
    it "has 38 matches" do 
      all_matches = Team.find(5).all_matches 
      expect(all_matches.length).to be(38)
    end
  end

  describe "home_team_wins and home_team_losses" do
    it "shows a losing record for Sunderland" do 
      sunderland = Team.find_by(name: "Sunderland AFC")
      expect(sunderland.home_team_wins.length).to be < sunderland.home_team_losses.length
    end 

    it "shows a combined home team wins/losses of 19" do 
      everton = Team.find_by(name: "Everton FC")
      expect(everton.home_team_wins.length + everton.home_team_losses.length + everton.home_team_draws.length).to be(19)
    end
  end



    # it 'should detect a simple anagram' do
    #   detector = Anagram.new('ba')
    #   ba = detector.match(['ab', 'abc', 'bac'])
    #   expect(ba).to eq(['ab'])
    # end
  
    # it 'should detect an anagram' do
    #   detector = Anagram.new('listen')
    #   listen = detector.match %w(enlists google inlets banana)
    #   expect(listen).to eq(['inlets'])
    # end
  
    # it 'should detect multiple anagrams' do
    #   detector = Anagram.new('allergy')
    #   allergy = detector.match %w(gallery ballerina regally clergy largely leading)
    #   expect(allergy).to eq(['gallery', 'regally', 'largely'])
    # end

  