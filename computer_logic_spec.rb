  # def default_return(name)
  # end
  # def simple_return(name)
  #   name
  #   1 == 1
  # end
  # it "checking method returns" do
  #   print "Calling default return "
  #   print default_return("some name")
  #   print "\nCalling simple return "
  #   print simple_return(" simple name")
  # end

load 'admin_logic.rb'
load 'computer_logic.rb'

describe "ComputerLogic" do

  before(:all) do
    @test_case = ComputerLogic.new
  end

  context "pertaining to first move" do
    it "should be selecting where the player's first move is" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}
      user_sign = "X"

      @test_case.player_first_turn?(possible_places, user_sign).should == {:a1=>"X"}
    end

    it "should be returning 1 if there is one move on the board" do
      first_turn = {:a1=>"X"}

      @test_case.player_first_turn_delegation(first_turn).should == 1
    end

    it "should not be returning 1 for all cases but one move" do
      first_turn = {:a1=>"X", :a2=>"X"}

      @test_case.player_first_turn_delegation(first_turn).should_not == 1
    end

    it "should be returning corner value if player picks center" do
      first_turn = {:b2=>"X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.player_first_move(first_turn)).to be_one_of([:a1,:a3,:c1,:c3])
    end


    it "should be returning center if user picks a corner value" do
      first_turn = {:a1=>"X"}

      @test_case.player_first_move(first_turn) == :b2
    end

   end

  context "pertaining to second move" do
    it "should be selecting where the player's first two move are" do
      possible_places = {a1: "X",a2: "X",a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}
      user_sign = "X"

      @test_case.player_second_turn?(possible_places, user_sign).should == {:a1=>"X", :a2=>"X"}
    end

    it "should be returning 2 if there are two moves on the board" do
      second_turn = {:a1=>"X", :a2=>"X"}

      @test_case.player_second_turn_delegation(second_turn).should == 2
    end

    it "should not be returning 2 for all cases but one move" do
      second_turn = {:a1=>"X"}

      @test_case.player_second_turn_delegation(second_turn).should_not == 2
    end
  end

    context "pertaining to the fork detections" do
      it "should be returning only a sample edge move value when there is a kitty fork type" do
        possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: "X"}
        user_sign = "X"

        RSpec::Matchers.define :be_one_of do |expected|
          match do |actual|
            expected.include?(actual)
          end
        end
        expect(@test_case.fork_detection_type_1(possible_places, user_sign)).to be_one_of([:a2,:b3,:c2,:b1])
      end
    end

    #it "should "

end
