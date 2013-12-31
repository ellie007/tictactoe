class ComputerLogic < Admin

  def player_first_turn?(possible_places, user_sign)
    @first_turn = possible_places.select { |key, value| value == user_sign }
  end


  def player_first_turn_delegation(first_turn)
    length_check = first_turn.length
    #if length_check == 1
    #  player_first_move
    #else
    #  player_second_turn_check?
    #end
  end


  def player_first_move(first_turn)
    check_center = first_turn.keys.first
    if check_center == :b2
      narrowed_possibilities = { a1: @a1,a3: @a3, c1: @c1,c3: @c3 }
      move = narrowed_possibilities.keys.sample
      #declare_computer_move(move)
    else
      move = :b2
      #declare_computer_move(move)
    end
  end


  def player_second_turn?(possible_places, user_sign)
    @second_turn = possible_places.select { |key, value| value == user_sign }
  end


  def player_second_turn_delegation(second_turn)
    length_check = second_turn.length
    #if length_check == 2
    #  fork_detection_type_1
    #else
    #  attack
    #end
  end


  #if the user is trying to do a fork from two corners
  def fork_detection_type_1(possible_places, user_sign)
    second_turn_check = possible_places.select { |key, value| value == user_sign }
    @corners = { a1:@a1, a3:@a3, c1:@c1, c3:@c3 }
    kitty_fork_check = second_turn_check.keys & @corners.keys
    if kitty_fork_check == [:a1, :c3] || kitty_fork_check == [:a3, :c1]
      move = { a2:@a2, b3:@b3, c2:@c2, b1:@b1 }.keys.sample
      #declare_computer_move(move)
    else
      #fork_detection_type_2
    end
  end


  #if the user is trying to do a fork from a center and a corner
  def fork_detection_type_2
    var = $possible_places.select { |key, value| value == $user_sign }
    if var.keys == [:a1,:b2] || var.keys == [:a3,:b2] || var.keys == [:b2, c1] || var.keys == [:b2,:c3]
      move = $possible_places.select { |key, value| key == :a1 || key == :a3 || key == :c1 || key == :c3 }.keys.sample
      #declare_computer_move(move)
    else
      #fork_detection_type_3
    end
  end


  #if a user is trying to do a fork from an edge and a corner
  def fork_detection_type_3
    var = $possible_places.select { |key, value| value == $user_sign }
    if var.keys == [:a1,:c2] || var.keys == [:a3,:c2]
      move = [:c1,:c3].sample
      declare_computer_move(move)
    elsif var.keys == [:a2,:c1] || var.keys == [:a2,:c3]
      move = [:a1,:a3].sample
      declare_computer_move(move)
    else
      attack
    end
  end


  def attack
    attack_count_and_index
    if @indexed_spot.empty? == true
      counter_attack
    else
      attack_counter_attack_find_spot_and_clean_up
      attack_set_value
    end
  end


  def attack_count_and_index
    only_computer_valued = $winning_propositions.map { |each_hash| each_hash.select { |key, value| value == $computer_sign } }
    count_of_each = only_computer_valued.map { |count_values_in_hash| count_values_in_hash.count }
    @indexed_spot = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
  end


  def attack_counter_attack_find_spot_and_clean_up
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
    else @nil_valued_array_true_false == [true] || @nil_valued_array_true_false == [true, true]
      counter_attack
    end
  end


  def counter_attack
    counter_attack_count_and_index
    if @indexed_spot.empty? == true
      random_move
    else
      attack_counter_attack_find_spot_and_clean_up
      counter_attack_set_value
    end
  end


  def counter_attack_count_and_index
    only_user_valued = $winning_propositions.map { |each_hash| each_hash.select { |key, value| value == $user_sign } }
    count_of_each = only_user_valued.map { |count_values_in_hash| count_values_in_hash.count }
    @indexed_spot = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
  end


  def counter_attack_set_value
    if @nil_valued_array_true_false.include?(false)
      move = @nil_valued_values_array[0].keys[0] unless @nil_valued_values_array[0] == nil
      declare_computer_move(move)
    else @nil_valued_array_true_false == [true] || @nil_valued_array_true_false == [true, true]
      random_move
    end
  end


  def random_move
    move = $possible_places.to_a.select { |key, value| value == nil }.sample.first
    declare_computer_move(move)
  end

end
