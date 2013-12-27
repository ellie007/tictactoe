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

load 'computer_logic.rb'

describe "ComputerLogic" do

  #player_first_turn_check?
  it "should be boiling down to a true for first move" do
    places = {
    a1: "X",a2: @a2,a3: @a3,
    b1: @b1,b2: @b2,b3: @b3,
    c1: @c1,c2: @c2,c3: @c3
    }
    first_move = ComputerLogic.new
    first_move.player_first_turn_check?(places).should == true
  end

  #player_first_turn_check?
  xit "should be boiling down to a false for first move" do
    places = {
    a1: @a1,a2: @a2,a3: @a3,
    b1: @b1,b2: @b2,b3: @b3,
    c1: @c1,c2: @c2,c3: @c3
    }
    first_move = ComputerLogic.new
    first_move.first_turn?(places).should == false
  end

  # it 'should be equaling to a only a certain subsets of guesses' do
  #   places = {
  #   a1: @a1,a2: @a2,a3: @a3,
  #   b1: @b1,b2: @b2,b3: @b3,
  #   c1: @c1,c2: @c2,c3: @c3}

  #   run_of_method = ComputerLogic.new
  #   run_of_method.player_first_move(places)
  #   move.should == :a1 || move.should == :a3 || move.should == :c1 || move.should == :c3 || move.should == :b2
  # end

  #player_second_turn_check?
  xit "returns false when there aren't two moves on the board" do
    places = {
    a1: @a1,a2: @a2,a3: @a3,
    b1: @b1,b2: @b2,b3: @b3,
    c1: @c1,c2: @c2,c3: @c3
    }
    second_move = ComputerLogic.new
    second_move.second_turn?(places).should == false
  end

  xit "" do
  end

  #player_second_turn_check?
  xit "returns true when there are two moves the board" do
    places = {
    a1: "X",a2: @a2,a3: "X",
    b1: @b1,b2: @b2,b3: @b3,
    c1: @c1,c2: @c2,c3: @c3
    }
    second_move = ComputerLogic.new
    second_move.second_turn?(places).should == true
  end

end
