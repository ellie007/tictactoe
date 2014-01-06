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
    it "should select where the player's first move is" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}
      user_sign = "X"

      @test_case.player_first_turn?(possible_places, user_sign).should == {:a1=>"X"}
    end

    it "should return 1 if there is one move on the board" do
      first_turn = {:a1=>"X"}

      @test_case.player_first_turn_delegation(first_turn).should == 1
    end

    it "should not be returning 1 for all cases but one move" do
      first_turn = {:a1=>"X", :a2=>"X"}

      @test_case.player_first_turn_delegation(first_turn).should_not == 1
    end

    it "should return corner value if player picks center" do
      first_turn = {:b2=>"X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.player_first_move(first_turn)).to be_one_of([:a1,:a3,:c1,:c3])
    end

    it "should return center if user picks a corner value" do
      first_turn = {:a1=>"X"}

      @test_case.player_first_move(first_turn) == :b2
    end
  end

  context "pertaining to second move" do
    it "should select where the player's first two move is" do
      possible_places = {a1: "X",a2: "X",a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}
      user_sign = "X"

      @test_case.player_second_turn?(possible_places, user_sign).should == {:a1=>"X", :a2=>"X"}
    end

    it "should return 2 if there are two moves on the board" do
      second_turn = {:a1=>"X", :a2=>"X"}

      @test_case.player_second_turn_delegation(second_turn).should == 2
    end

    it "should not be returning 2 for all cases but two moves" do
      second_turn = {:a1=>"X"}

      @test_case.player_second_turn_delegation(second_turn).should_not == 2
    end
  end

  context "pertaining to the fork detections type 1" do
    it "should return one sample edge move value when there is a kitty fork type(a1,c3)" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: "X"}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_1(possible_places, user_sign)).to be_one_of([:a2,:b3,:c2,:b1])
    end


    it "should return one sample edge move value when there is a kitty fork type(a3,c1)" do
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: @b2,b3: @b3,c1: "X",c2: @c2,c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_1(possible_places, user_sign)).to be_one_of([:a2,:b3,:c2,:b1])
    end
  end

  context "pertaining to the fork detection type 2" do
    it "should return one sample corner move value when there is a type 2 fork detection(a1, b2)" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(possible_places, user_sign)).to be_one_of([:a1, :a3, :c1, :c3])
    end

    it "should return one sample corner move value when there is a type 2 fork detection(a3, b2)" do
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: "X",b3: @b3,c1: @c2,c2: @c2,c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(possible_places, user_sign)).to be_one_of([:a1, :a3, :c1, :c3])
    end

    it "should return one sample corner move value when there is a type 2 fork detection(b2, c1)" do
      possible_places = {a1: @a1,a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: "X",c2: @c2,c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(possible_places, user_sign)).to be_one_of([:a1, :a3, :c1, :c3])
    end

    it "should return one sample corner move value when there is a type 2 fork detection(b2, c3)" do
      possible_places = {a1: @a1,a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: "X"}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(possible_places, user_sign)).to be_one_of([:a1, :a3, :c1, :c3])
    end
  end

  context "pertaining to the fork detection type 3" do
    it "should return one adjacent corner value when there is a type 3 fork detection(a1, c2)" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: "X",c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(possible_places, user_sign)).to be_one_of([:c1, :c3])
    end

    it "should return one adjacent corner value when there is a type 3 fork detection(a3, c2)" do
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: "X",c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(possible_places, user_sign)).to be_one_of([:c1, :c3])
    end

    it "should return one adjacent corner value when there is a type 3 fork detection(a2, c1)" do
      possible_places = {a1: @a1,a2: "X",a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: "X",c2: @c2,c3: @c3}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(possible_places, user_sign)).to be_one_of([:a1, :a3])
    end

    it "should return one adjacent corner value when there is a type 3 fork detection(a2, c3)" do
      possible_places = {a1: @a1,a2: "X",a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: "X"}
      user_sign = "X"

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(possible_places, user_sign)).to be_one_of([:a1, :a3])
    end
  end

  context "pertaining to attack method" do
    it "should return the index values" do
      winning_propositions=[{:a1=>"X", :a2=>nil, :a3=>"O"}, {:b1=>nil, :b2=>"X", :b3=>nil}, {:c1=>nil, :c2=>nil, :c3=>"O"}, {:a1=>"X", :b1=>nil, :c1=>nil}, {:a2=>nil, :b2=>"X", :c2=>nil}, {:a3=>"O", :b3=>nil, :c3=>"O"}, {:a1=>"X", :b2=>"X", :c3=>"O"}, {:a3=>"O", :b2=>"X", :c1=>nil}]
      computer_sign = "O"

      @test_case.attack_count_and_index(winning_propositions, computer_sign).should == [5]
    end

  end



  context "pertaining to random move method" do
    it "should find a empty cell to make a random move" do
      possible_places = {a1: @a1,a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.random_move(possible_places)).to be_one_of([:a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3])
    end
  end

end
