class TicTacToe

  def player_first_move
    first_turn_check = @possible_places.select { |key, value| value == @user_sign }
      if first_turn_check.length == 1
        check_center = first_turn_check.keys.first
        if check_center == :b2
          @narrowed_possibilities = { a1: @a1,a3: @a3, c1: @c1,c3: @c3 }
          move = @narrowed_possibilities.keys.sample
          @possible_places[move] = @comp_sign

          #changes the winning prop values in parallel
          list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
              change_hash_value[move] = @comp_sign
            end

          puts @comp_name + " made the move: #{move}"
          display_game_board
#puts "I picked a corner"
        else
          @possible_places[:b2] = @comp_sign
          puts @comp_name + " made the move: #{:b2}"
          display_game_board
#puts "I picked the center"

          #changes the winning prop values in parallel
          list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(:b2.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
              change_hash_value[:b2] = @comp_sign
            end
        end
      else
        second_turn_check
      end
  end

  def second_turn_check
    first_turn_check = @possible_places.select { |key, value| value == @user_sign }
    if first_turn_check.length == 2
      fork_detection
#puts "I am preceding to do the fork detection method."
    else
        comp_find
#puts "There is more than 2, precede to comp find."
    end
  end

  def fork_detection
    second_turn_check = @possible_places.select { |key, value| value == @user_sign }
    @corners = { a1:@a1, a3:@a3, c1:@c1, c3:@c3 }
    kitty_fork_check = second_turn_check.keys & @corners.keys
      if kitty_fork_check == [:a1, :c3] || kitty_fork_check == [:a3, :c1]
        side_middle = { a2:@a2, b3:@b3, c2:@c2, b1:@b1 }.keys.sample
        @possible_places[side_middle] = @comp_sign
        puts @comp_name + " made the move: #{side_middle}"
        display_game_board
#puts "Fork Detected-Kitty Style!"

        #changes the winning prop values in parallel
        list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(side_middle.to_s) }
          list_of_matching_arrays.each do |change_hash_value|
            change_hash_value[side_middle] = @comp_sign
          end
      else
          comp_find
      end
  end

  def random_move
    hash_to_array = @possible_places.to_a
    only_nil_valued_hash = hash_to_array.select { |key, value| value == nil }
    random_array_hash_value = only_nil_valued_hash.sample
    move = random_array_hash_value.first
    @possible_places[move] = @comp_sign
    puts @comp_name + " made the move: #{move}"

    #changes the winning prop values in parallel
    list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
      list_of_matching_arrays.each do |change_hash_value|
        change_hash_value[move] = @comp_sign
      end
    display_game_board
#puts "I picked a random spot by way of the random move method"
    end

  def comp_find
    only_comp_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @comp_sign } }
    count_of_each = only_comp_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    index_array = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
      if index_array.empty? == true
        comp_block
      else
        @nil_valued_values_array = []
        @nil_valued_array_true_false = []
          index_array.each do |element|
            @nil_valued_values_array += [@winning_propositions[element].select { |key, value| value == nil }]
            @nil_valued_array_true_false += [@winning_propositions[element].select { |key, value| value == nil }.empty?]
          end

    if @nil_valued_values_array.include?({})
      @nil_valued_values_array.delete({})
    end
    move = @nil_valued_values_array[0].keys[0] unless @nil_valued_values_array[0] == nil

        if @nil_valued_array_true_false.include?(false)
          @possible_places[move] = @comp_sign
            #changes the winning prop values in parallel
              list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
                list_of_matching_arrays.each do |change_hash_value|
                  change_hash_value[move] = @comp_sign
                end
          puts @comp_name + " made the move: #{move}"
          display_game_board
        else @nil_valued_array_true_false == [true] || @nil_valued_array_true_false == [true, true]
         comp_block
        end
      end
    end

  def comp_block
    only_user_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @user_sign } }
    count_of_each = only_user_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    index_array = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
      if index_array.empty? == true
        random_move
      else
        @nil_valued_values_array = []
        @nil_valued_array_true_false = []
          index_array.each do |element|
            @nil_valued_values_array += [@winning_propositions[element].select { |key, value| value == nil }]
            @nil_valued_array_true_false += [@winning_propositions[element].select { |key, value| value == nil }.empty?]
          end

    if @nil_valued_values_array.include?({})
      @nil_valued_values_array.delete({})
    end
    move = @nil_valued_values_array[0].keys[0] unless @nil_valued_values_array[0] == nil

        if @nil_valued_array_true_false.include?(false)
          @possible_places[move] = @comp_sign
            #changes the winning prop values in parallel
              list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
                list_of_matching_arrays.each do |change_hash_value|
                  change_hash_value[move] = @comp_sign
                end
          puts @comp_name + " made the move: #{move}"
          display_game_board
#puts "Here I am defending/BLOCKED!!!!!!"
        else @nil_valued_array_true_false == [true] || @nil_valued_array_true_false == [true, true]
         random_move
        end
      end
  end

end
