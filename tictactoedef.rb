class TicTacToe

  attr_accessor :a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3

  def comp_name
    @comp_name = "Watson"
  end

  def user_name1
    @user_name = gets.chomp
  end

  def user_name2
    @user_name = @user_name
  end

  def user_sign
    if gets.chomp.upcase == "O"
      @user_sign = "O"
    else
      @user_sign = "X"
    end
  end

  def comp_sign
    @user_sign == "X" ? @comp_sign = "O" : "X"
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
            puts @user_name + " made the move: #{input}"
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

  def player_first_move_or_second_move
      first_turn_check = @possible_places.select { |key, value| value == @user_sign }
      if first_turn_check.length == 1
        check_center = first_turn_check.keys.first
        if check_center == :b2
          @narrowed_possibilities = {a1: @a1,a3: @a3, c1: @c1,c3: @c3}
          move = @narrowed_possibilities.keys.sample
          @possible_places[move] = @comp_sign

          #changes the winning prop values in parallel
          list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
              change_hash_value[move] = @comp_sign
            end

          puts @comp_name + " made the move: #{move}"
          display_game_board
puts "I picked a corner"
        else
          @possible_places[:b2] = @comp_sign
          puts @comp_name + " made the move: #{:b2}"
          display_game_board
puts "I picked the center"


          #changes the winning prop values in parallel
          list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(:b2.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
              change_hash_value[:b2] = @comp_sign
            end

        end
      elsif first_turn_check.length == 2
         fork_detection
puts "I am preceding to do the fork detection method."
      else
        comp_find
puts "There is more than 2, precede to comp find, not fork."
      end
  end


  def fork_detection
    second_turn_check = @possible_places.select { |key, value| value == @user_sign }
    @corners = {a1:@a1, a3:@a3, c1:@c1, c3:@c3}
    kitty_fork_check = second_turn_check.keys & @corners.keys
      if kitty_fork_check == [:a1, :c3] || kitty_fork_check == [:a3, :c1]
        side_middle = {a2:@a2, b3:@b3, c2:@c2, b1:@b1}.keys.sample
        @possible_places[side_middle] = @comp_sign
        puts @comp_name + " made the move: #{side_middle}"
        display_game_board
puts "Fork Detected-Kitty Style!"

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
    only_nil_valued_hash = hash_to_array.select {|key, value| value==nil}
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
puts "I picked a random spot by way of the random move method"
    end

  def comp_find
    only_comp_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @comp_sign } }
    count_of_each = only_comp_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    index_array = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
      if index_array.empty? != true
        index_array.each do |element|
            if @winning_propositions[element].has_value?(nil)
              nil_valued = @winning_propositions[element].select { |key, value| value == nil }
              @possible_places[nil_valued.keys.first] = @comp_sign
        #changes the winning prop values in parallel
              list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(nil_valued.keys.first.to_s) }
                list_of_matching_arrays.each do |change_hash_value|
                  change_hash_value[nil_valued.keys.first] = @comp_sign
                end
      puts @comp_name + " made the move: #{nil_valued.keys.first}"
      display_game_board
      comp_win
puts "I am building off of a strategy, two of mine were present."
            else
              comp_turn
puts "There were two of MINE present but didn't meet the condition of nil value."
            end
        end
      else
        comp_turn
      end
   end

  def comp_turn
#    only_user_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @user_sign } }
#     count_of_each = only_user_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
#     index_array = count_of_each.each_with_index.select { |num, index| num == 2 }.map { |index_spot| index_spot[1] }
#       if index_array.empty? != true
#         index_array.each do |element|
#             if @winning_propositions[element].has_value?(nil)
#               nil_valued = @winning_propositions[element].select { |key, value| value == nil }
#               @possible_places[nil_valued.keys.first] = @comp_sign
#         #changes the winning prop values in parallel
#               list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(nil_valued.keys.first.to_s) }
#                 list_of_matching_arrays.each do |change_hash_value|
#                   change_hash_value[nil_valued.keys.first] = @comp_sign
#                 end
#       puts @comp_name + " made the move: #{nil_valued.keys.first}"
#       display_game_board
# puts "Here I am defending/BLOCKED!"
#             else
#               random_move
# puts "There were two of PLAYER'S present but didn't meet the condition of nil value."
#             end
#         end
#       else
#         random_move
#       end
#    end
#__________________________________________________________________________
    #comp find a spot with two of its spots already
    only_user_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @user_sign } }
    count_of_each = only_user_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
      if count_of_each.include?(2) == true
        indexed_hashed = Hash[count_of_each.map.with_index.to_a]
        indexed_value = indexed_hashed[2]
          if @winning_propositions[indexed_value].has_value?(nil)
            nil_valued = @winning_propositions[indexed_value].select { |key, value| value == nil }
            the_symbol = nil_valued.first.first
            @possible_places[the_symbol] = @comp_sign

            # changes the winning prop values in parallel
            list_of_matching_arrays = @winning_propositions.select { |key, value| key.to_s.match(the_symbol.to_s) }
              list_of_matching_arrays.each do |change_hash_value|
                change_hash_value[the_symbol] = @comp_sign
              end

            puts @comp_name + " made the move: #{the_symbol}"
            display_game_board
puts "Here I am defending/BLOCKED!"
          else
            random_move
puts "Two of player's were present but I was in the third spot."
          end
        else
          random_move
puts "The PLAYER didn't have two and any winning strategy to build off of."
        end
  end
#__________________________________________________________________________

  def comp_win
    #fix this, why not reading from prior def correctly?!!!!!!!!!!!!
    @user_sign == "X" ? @comp_sign = "O" : "X"

    a = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @comp_sign } }
    b = a.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    b.each { |number_count| puts 'I, Watson, have won.  Better luck next time. :)' if number_count == 3 }
    b.each { |number_count| exit if number_count == 3 }
  end

  def player_win
    a = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @user_sign } }
    b = a.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    b.each { |number_count| puts 'Player won.  That is not possible.  FIX' if number_count == 3 }
    b.each { |number_count| exit if number_count == 3 }
  end

  def draw_game
    if @possible_places.length == 9
      puts "Draw game.  You are formidable competition; good job!"
      exit
    end
  end

end
