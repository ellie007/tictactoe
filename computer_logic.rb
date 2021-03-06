class ComputerLogic < Admin

  def computer_turn(possible_places, winning_propositions)
    if player_first_turn?(possible_places)
      #return computer_first_move
    elsif attack(winning_propositions)
      #return attack(winning_propositions)
    elsif counter_attack(winning_propositions)
      #return counter_attack(winning_propositions)
    elsif fork_play?(possible_places)
      #return fork_play?(possible_places)
    else random_move(possible_places)
      #return random_move(possible_places)
    end
  end

  def player_first_turn?(possible_places)
    @first_turn = possible_places.select { |key, value| value == $user_sign }
    if @first_turn.length == 1
      return computer_first_move
    else
      return false
    end
  end

  def computer_first_move
    check_center = @first_turn.keys.first
    if check_center == :b2
      move = { a1: @a1,a3: @a3, c1: @c1,c3: @c3 }.keys.sample
      #return declare_computer_move(move)
    else
      move = :b2
      #return declare_computer_move(move)
    end
  end

  def fork_play?(possible_places)
    #@possible_places = possible_places
    @second_turn = possible_places.select { |key, value| value == $user_sign }
    if @second_turn.length == 2
      return run_fork_detection_tests
    else
      return false
    end
  end

  def run_fork_detection_tests
    if fork_detection_type_1
      return true
    elsif fork_detection_type_2
      return true
    elsif fork_detection_type_3
      return true
    elsif fork_detection_type_3_mirror
      return true
    elsif fork_detection_type_4
    else
      return false
    end
  end

  #if the user is trying to do a fork from two corners, go in edge
  def fork_detection_type_1#(second_turn)
    if @second_turn.keys == [:a1, :c3] || @second_turn.keys == [:a3, :c1]
      move = { a2:@a2, b3:@b3, c2:@c2, b1:@b1 }.keys.sample
      return declare_computer_move(move)
    else
      return false
    end
  end


  #if the user is trying to do a fork from a center and a corner, go in empty corner
  def fork_detection_type_2#(second_turn, possible_places)
    if @second_turn.keys == [:a1,:b2] || @second_turn.keys == [:a3,:b2] || @second_turn.keys == [:b2, :c1] || @second_turn.keys == [:b2,:c3]
      var = $possible_places.select { |key, value| value ==nil }.keys & [:a1, :a3, :c1, :c3]
      move = var.sample
      return declare_computer_move(move)
    else
      return false
    end
  end


  #if a user is trying to do a fork from an edge and a corner, go in one of adjacent corners
  def fork_detection_type_3#(second_turn)
    if @second_turn.keys == [:a1,:c2] || @second_turn.keys == [:a3,:c2]
      move = [:c1,:c3].sample
      return declare_computer_move(move)
    elsif @second_turn.keys == [:a2,:c1] || @second_turn.keys == [:a2,:c3]
      move = [:a1,:a3].sample
      return declare_computer_move(move)
    else
      return false
    end
  end

  #if a user is trying to do a fork from an edge and a corner, go in one of adjacent corners
  def fork_detection_type_3_mirror
    if @second_turn.keys == [:a1,:b3] || @second_turn.keys == [:c1,:b3]
      move = [:a3,:c3].sample
      return declare_computer_move(move)
    elsif @second_turn.keys == [:b2,:a1] || @second_turn.keys == [:b2,:c3]
      move = [:a1,:c1].sample
      return declare_computer_move(move)
    else
      return false
    end
  end

  #if a user is trying to do a fork from two edges, go in corner
    def fork_detection_type_4
      if @second_turn.keys == [:a2,:b1] || @second_turn.keys == [:a2,:b3]
        move = [:a1,:a3].sample
        return declare_computer_move(move)
      elsif @second_turn.keys == [:b1,:c2] || @second_turn.keys == [:b3,:c2]
        move = [:c1,:c3]
        return declare_computer_move(move)
      else
        return false
      end
    end

  def attack(winning_propositions)
    attack_count_and_index(winning_propositions)
    attack_find_spot_and_clean_up(winning_propositions)
    attack_set_value(winning_propositions)
  end

  def attack_count_and_index(winning_propositions)
    only_computer_valued = winning_propositions.map { |each_hash| each_hash.select { |key, value| value == $computer_sign } }
    count_of_each = only_computer_valued.map { |count_values_in_hash| count_values_in_hash.count }
    @indexed_spot = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
  end

  def attack_find_spot_and_clean_up(winning_propositions)
    @nil_valued_values_array = []
    @nil_valued_array_true_false = []
    @indexed_spot.each do |element|
      @nil_valued_values_array += [winning_propositions[element].select { |key, value| value == nil }]
      @nil_valued_array_true_false += [winning_propositions[element].select { |key, value| value == nil }.empty?]
    end
    if @nil_valued_values_array.include?({})
      @nil_valued_values_array.delete({})
    end
  end

  def attack_set_value(winning_propositions)
    if @nil_valued_array_true_false.include?(false)
      move = @nil_valued_values_array[0].keys[0]
      #return declare_computer_move(move)
    else
      return false
    end
  end

  def counter_attack(winning_propositions)
    counter_attack_count_and_index(winning_propositions)
    counter_attack_find_spot_and_clean_up(winning_propositions)
    counter_attack_set_value(winning_propositions)
  end

  def counter_attack_count_and_index(winning_propositions)
    only_user_valued = winning_propositions.map { |each_hash| each_hash.select { |key, value| value == user_sign } }
    count_of_each = only_user_valued.map { |count_values_in_hash| count_values_in_hash.count }
    @indexed_spot = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
  end

  def counter_attack_find_spot_and_clean_up(winning_propositions)
    @nil_valued_values_array = []
    @nil_valued_array_true_false = []
    @indexed_spot.each do |element|
      @nil_valued_values_array += [winning_propositions[element].select { |key, value| value == nil }]
      @nil_valued_array_true_false += [winning_propositions[element].select { |key, value| value == nil }.empty?]
    end
    if @nil_valued_values_array.include?({})
      @nil_valued_values_array.delete({})
    end
  end

  def counter_attack_set_value(winning_propositions)
    if @nil_valued_array_true_false.include?(false)
      move = @nil_valued_values_array[0].keys[0]
      #return declare_computer_move(move)
    else
      return false
    end
  end

  def random_move(possible_places)
    move = possible_places.to_a.select { |key, value| value == nil }.sample.first
    #return declare_computer_move(move)
  end

end
