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
  #   print simple_return("simple name")
  # end

load 'admin_logic.rb'
load 'computer_logic.rb'

describe "ComputerLogic" do

  before(:all) do
    @test_case = ComputerLogic.new
    $user_sign = "X"
    $computer_name = "Watson"
    $computer_sign = "O"
  end

  context "pertaining to computer_turn" do
  end


  context "pertaining to player_first_turn?" do
    it "should: if player picks corner then computer picks center" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}

      @test_case.player_first_turn?(possible_places).should == :b2
    end

     it "should: if player picks center then computer picks corner" do
      possible_places = {a1: @a1,a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: @c3}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.player_first_turn?(possible_places)).to be_one_of([:a1,:a3,:c1,:c3])
    end

    it "should return false because not the first move" do
      possible_places = {a1: "X",a2: "X",a3: @a3,b1: @b1,b2: "O",b3: @b3,c1: @c1,c2: @c2,c3: @c3}

      @test_case.player_first_turn?(possible_places).should == false
    end
  end


  context "pertaining to fork_play? and run_fork_detection_tests" do
    it "should return false because not fork because not second move" do
      possible_places = {a1: @a1,a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: @c3}

      @test_case.fork_play?(possible_places).should == false
    end
  end


  context "pertaining to fork detection type 1" do
    xit "should return one sample edge move value when there is a kitty fork type (a1,c3)" do
      second_turn = {a1: "X", c3: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_1(second_turn)).to be_one_of([:a2,:b3,:c2,:b1])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 1 (a1,c3)" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: "O",b3: @b3,c1: @c1,c2: @c2,c3: "X"}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one sample edge move value when there is a kitty fork type (a3,c1)" do
      second_turn = {a3: "X", c1: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_1(second_turn)).to be_one_of([:a2,:b3,:c2,:b1])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 1 (a3,c1)" do
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: "O",b3: @b3,c1: "X",c2: @c2,c3: @a3}

      @test_case.fork_play?(possible_places).should == true
    end
  end


  context "pertaining to fork detection type 2" do
    xit "proves running test two OR should return one sample corner move value when there is a type 2 fork detection(a1, b2)" do
      second_turn = second_turn = {a1: "X", b2: "X"}
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: "O"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(second_turn, possible_places)).to be_one_of([:a3, :c1])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 2 (a1,b2)" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: "O"}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one sample corner move value when there is a type 2 fork detection(a3, b2)" do
      second_turn = {a3: "X", b2: "X"}
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: "X",b3: @b3,c1: "O",c2: @c2,c3: @c3}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(second_turn, possible_places)).to be_one_of([:a1, :c3])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 2 (a3,b2)" do
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: "X",b3: @b3,c1: "O",c2: @c2,c3: @c3}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one sample corner move value when there is a type 2 fork detection(b2, c1)" do
      second_turn = {b2: "X", c1: "X"}
      possible_places = {a1: @a1,a2: @a2,a3: "O",b1: @b1,b2: "X",b3: @b3,c1: "X",c2: @c2,c3: @c3}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(second_turn, possible_places)).to be_one_of([:a1, :c3])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 2 (b2,c1)" do
      possible_places = {a1: @a1,a2: @a2,a3: "O",b1: @b1,b2: "X",b3: @b3,c1: "X",c2: @c2,c3: @c3}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one sample corner move value when there is a type 2 fork detection(b2, c3)" do
      second_turn = {b2: "X", c3: "X"}
      possible_places = {a1: "O",a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_2(second_turn, possible_places)).to be_one_of([:a3, :c1])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 2 (b2,c3)" do
      possible_places = {a1: "O",a2: @a2,a3: @a3,b1: @b1,b2: "X",b3: @b3,c1: @c1,c2: @c2,c3: "X"}

      @test_case.fork_play?(possible_places).should == true
    end
  end


  context "pertaining to fork detection type 3" do
    xit "should return one adjacent corner value when there is a type 3 fork detection(a1, c2)" do
      second_turn = {a1: "X", c2: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(second_turn)).to be_one_of([:c1, :c3])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 3 (a1, c2)" do
      possible_places = {a1: "X",a2: @a2,a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: "X",c3: @c3}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one adjacent corner value when there is a type 3 fork detection(a3, c2)" do
      second_turn = {a3: "X", c2: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(second_turn)).to be_one_of([:c1, :c3])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 3 (a3, c2)" do
      possible_places = {a1: @a1,a2: @a2,a3: "X",b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: "X",c3: @c3}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one adjacent corner value when there is a type 3 fork detection(a2, c1)" do
      second_turn = {a2: "X", c1: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(second_turn)).to be_one_of([:a1, :a3])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 3 (a1, c2)" do
      possible_places = {a1: @a1,a2: "X",a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: "X",c2: @c2,c3: @c3}

      @test_case.fork_play?(possible_places).should == true
    end

    xit "should return one adjacent corner value when there is a type 3 fork detection(a2, c3)" do
      second_turn = {a2: "X", c3: "X"}

      RSpec::Matchers.define :be_one_of do |expected|
        match do |actual|
          expected.include?(actual)
        end
      end
      expect(@test_case.fork_detection_type_3(second_turn)).to be_one_of([:a1, :a3])
    end
    #EITHER OR TEST; turn off second_turn instance variables and arguments
    xit "should return true value and cascading correctly for fork type 3 (a1, c2)" do
      possible_places = {a1: @a1,a2: "X",a3: @a3,b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: "X"}

      @test_case.fork_play?(possible_places).should == true
    end
  end


  context "pertaining to attack method" do
    xit "should return the index values" do
      winning_propositions=[{:a1=>"X", :a2=>nil, :a3=>"O"}, {:b1=>nil, :b2=>"X", :b3=>nil}, {:c1=>nil, :c2=>nil, :c3=>"O"}, {:a1=>"X", :b1=>nil, :c1=>nil}, {:a2=>nil, :b2=>"X", :c2=>nil}, {:a3=>"O", :b3=>nil, :c3=>"O"}, {:a1=>"X", :b2=>"X", :c3=>"O"}, {:a3=>"O", :b2=>"X", :c1=>nil}]

      @test_case.attack_count_and_index(winning_propositions).should == [5]
    end

  end


  context "pertaining to random move method" do
    xit "should find a empty cell to make a random move" do
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
