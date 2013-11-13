class TicTacToe

  attr_accessor :a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3

  def comp_name
    @comp_name = "Watson"
  end

  def user_name
    @user_name = gets.chomp
  end

  def user_sign
    @user_sign = "X"
  end

  def comp_sign
    @comp_sign = "O"
  end

  def game_board
    @possible_places = {
    a1: @a1,a2: @a2,a3: @a3,
    b1: @b1,b2: @b2,b3: @b3,
    c1: @c1,c2: @c2,c3: @c3
   }
  end

  def display_game_board
    puts "  #{@possible_places[:a1]} | #{@possible_places[:a2]}  | #{@possible_places[:a3]}"
    puts "--- --- ---"
    puts "  #{@possible_places[:b1]} | #{@possible_places[:b2]}  | #{@possible_places[:b3]}"
    puts "--- --- ---"
    puts "  #{@possible_places[:c1]} | #{@possible_places[:c2]}  | #{@possible_places[:c3]}"
  end

  def winning_propositions
    @winning_propositions = [
    {a1:@a1, a2:@a2, a3:@a3},
    {b1:@b1, b2:@b2, b3:@b3},
    {c1:@c1, c2:@c2, c3:@c3},

    {a1:@a1, b1:@b1, c1:@c1},
    {a2:@a1, b2:@b2, c2:@c2},
    {a3:@a3, b3:@b3, c3:@c3},

    {a1:@a1, b2:@b2, c3:@c3},
    {a3:@a3, b2:@b2, c1:@c3}
    ]
  end

  def user_turn
    input = gets.chomp.downcase.to_sym
      case input
        when 'a1'.to_sym, 'a2'.to_sym, 'a3'.to_sym, 'b1'.to_sym, 'b2'.to_sym, 'b3'.to_sym, 'c1'.to_sym, 'c2'.to_sym, 'c3'.to_sym
          if @possible_places[input] != nil
            puts "Spot is occupied, please choose an empty space."
            user_turn
          else
            @possible_places[input] = @user_sign
            puts "#{@user_name} made the move: #{input}"
            display_game_board

      list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(input.to_s) }
        list_of_matching_arrays.each do |change_hash_value|
          change_hash_value[input] = @user_sign
        end
          end
        else
          puts "Please respond in the format of e.g.; a1, c2, etc."
          user_turn
      end
  end

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

        if @nil_valued_array_true_false == [false] || @nil_valued_array_true_false == [true, false] || @nil_valued_array_true_false == [false, true]
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

        if @nil_valued_array_true_false == [false] || @nil_valued_array_true_false == [true, false] || @nil_valued_array_true_false == [false, true]
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

  def comp_win
    a = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @comp_sign } }
    b = a.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    b.each { |number_count| puts 'I, Watson, have won.  Better luck next time. :)' if number_count == 3 }
    b.each { |number_count| exit if number_count == 3 }
  end

  # def player_win
  #   a = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @user_sign } }
  #   b = a.map { |count_the_items_in_hash| count_the_items_in_hash.count }
  #   b.each { |number_count| puts 'Player won.  That is not possible.  FIX' if number_count == 3 }
  #   b.each { |number_count| exit if number_count == 3 }
  # end

  def draw_game
    puts "Draw game.  You are formidable competition; good job!" if @possible_places.values.include?(nil) == false
    exit if @possible_places.values.include?(nil) == false
  end

end
