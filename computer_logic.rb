class ComputerLogic < Admin

  def computer_turn
    if player_first_turn?
    elsif attack
    elsif counter_attack
    elsif fork_play?
    else random_move
    end
  end

  def player_first_turn?#(possible_places, user_sign)
    @first_turn = $possible_places.select { |key, value| value == $user_sign }
    if @first_turn.length == 1
      computer_first_move
    else
      return false
    end
  end


  def computer_first_move#(first_turn)
    player_took_center = @first_turn.keys.first
    if player_took_center == :b2
      move = { a1: @a1,a3: @a3, c1: @c1,c3: @c3 }.keys.sample
      declare_computer_move(move)
    else
      move = :b2
      declare_computer_move(move)
    end
  end


  def fork_play?#(possible_places, user_sign)
    @second_turn = $possible_places.select { |key, value| value == $user_sign }
    if @second_turn.length == 2
      run_fork_detection_tests
    else
      return false
    end
  end

  def run_fork_detection_tests
    if fork_detection_type_1
    elsif fork_detection_type_2
    else fork_detection_type_3
    end
  end

  #if the user is trying to do a fork from two corners, need to go in edge
  def fork_detection_type_1#(possible_places, user_sign)
    if @second_turn.keys == [:a1, :c3] || @second_turn.keys == [:a3, :c1]
      move = { a2:@a2, b3:@b3, c2:@c2, b1:@b1 }.keys.sample
      declare_computer_move(move)
    else
      return false
    end
  end


  #if the user is trying to do a fork from a center and a corner, need to go in corner
  def fork_detection_type_2#(possible_places, user_sign)
    if @second_turn.keys == [:a1,:b2] || @second_turn.keys == [:a3,:b2] || @second_turn.keys == [:b2, :c1] || @second_turn.keys == [:b2,:c3]
      move = $possible_places.select { |key, value| key == :a1 || key == :a3 || key == :c1 || key == :c3 && value == nil }.keys.sample
      declare_computer_move(move)
    else
      return false
    end
  end


  #if a user is trying to do a fork from an edge and a corner, need to go in adjacent corners
  def fork_detection_type_3#(possible_places, user_sign)
    if @second_turn.keys == [:a1,:c2] || @second_turn.keys == [:a3,:c2]
      move = [:c1,:c3].sample
      declare_computer_move(move)
    elsif @second_turn.keys == [:a2,:c1] || @second_turn.keys == [:a2,:c3]
      move = [:a1,:a3].sample
      declare_computer_move(move)
    else
      return false
    end
  end


  def attack
    attack_count_and_index
    if @indexed_spot.empty? == true
      return false
    else
      attack_find_spot_and_clean_up
      attack_set_value
    end
  end


  def attack_count_and_index#(winning_propositions, computer_sign)
    only_computer_valued = $winning_propositions.map { |each_hash| each_hash.select { |key, value| value == computer_sign } }
    count_of_each = only_computer_valued.map { |count_values_in_hash| count_values_in_hash.count }
    @indexed_spot = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
  end


  def attack_find_spot_and_clean_up#(winning_propositions)
    @nil_valued_values_array = []
    @nil_valued_array_true_false = []
    @indexed_spot.each do |element|
      @nil_valued_values_array += [$winning_propositions[element].select { |key, value| value == nil }]
      @nil_valued_array_true_false += [$winning_propositions[element].select { |key, value| value == nil }.empty?]
    end
    if @nil_valued_values_array.include?({})
      @nil_valued_values_array.delete({})
    end
  end


  def attack_set_value
    if @nil_valued_array_true_false.include?(false)
      move = @nil_valued_values_array[0].keys[0] unless @nil_valued_values_array[0] == nil
      declare_computer_move(move)
    #else @nil_valued_array_true_false == [true] || @nil_valued_array_true_false == [true, true]
      #counter_attack
    end
  end


  def counter_attack
    counter_attack_count_and_index
    if @indexed_spot.empty? == true
      return false
    else
      counter_attack_find_spot_and_clean_up
      counter_attack_set_value
    end
  end


  def counter_attack_count_and_index
    only_user_valued = $winning_propositions.map { |each_hash| each_hash.select { |key, value| value == $user_sign } }
    count_of_each = only_user_valued.map { |count_values_in_hash| count_values_in_hash.count }
    @indexed_spot = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
  end


  def counter_attack_find_spot_and_clean_up#(winning_propositions)
    @nil_valued_values_array = []
    @nil_valued_array_true_false = []
    @indexed_spot.each do |element|
      @nil_valued_values_array += [$winning_propositions[element].select { |key, value| value == nil }]
      @nil_valued_array_true_false += [$winning_propositions[element].select { |key, value| value == nil }.empty?]
    end
    if @nil_valued_values_array.include?({})
      @nil_valued_values_array.delete({})
    end
  end


  def counter_attack_set_value
    if @nil_valued_array_true_false.include?(false)
      move = @nil_valued_values_array[0].keys[0] unless @nil_valued_values_array[0] == nil
      declare_computer_move(move)
    #else @nil_valued_array_true_false == [true] || @nil_valued_array_true_false == [true, true]
      #player_second_turn?
    end
  end


  def random_move#(possible_places)
    move = $possible_places.to_a.select { |key, value| value == nil }.sample.first
    declare_computer_move(move)
  end

end
