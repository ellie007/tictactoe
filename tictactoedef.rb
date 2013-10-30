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
    input=gets.chomp.to_sym
    @possible_places[input] = @user_sign
    puts @user_name + " made the move: #{input}"
    display_game_board

     list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(input.to_s) }
      list_of_matching_arrays.each do |change_hash_value|
        change_hash_value[input]=@user_sign
      end
       #print @winning_propositions
  end

#comp find random place
    def random_move
          hash_to_array = @possible_places.to_a
          only_nil_valued_hash = hash_to_array.select {|key, value| value==nil}
          random_array_hash_value = only_nil_valued_hash.sample
          move = random_array_hash_value.first
          @possible_places[move] = @comp_sign
          puts @comp_name + " made the move: #{move}"

        #changes the winning prop values in parallel
          list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
              change_hash_value[move] = @comp_sign
          end
    #puts "Harry"
    display_game_board
    end

  def comp_turn
        #fix this, why not reading from prior def correctly?!!!!!!!!!!!!
            @user_sign == "X" ? @comp_sign = "O" : "X"

 # comp find a spot with two of its spots already

    only_user_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @user_sign }}
    count_of_each = only_user_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
      if count_of_each.include?(2) == true
        indexed_hashed = Hash[count_of_each.map.with_index.to_a]
        indexed_value = indexed_hashed[2]
          if @winning_propositions[indexed_value].has_value?(nil)
            nil_valued = @winning_propositions[indexed_value].select { |key, value| value == nil }
            the_symbol = nil_valued.first.first
            #@winning_propositions[indexed_value][the_symbol] = @comp_sign
            @possible_places[the_symbol] = @comp_sign

            #changes the winning prop values in parallel
          list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(the_symbol.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
               change_hash_value[the_symbol] = @comp_sign
            end

            puts @comp_name + " made the move: #{the_symbol}"
            display_game_board
            #print @winning_propositions
            comp_win
            #puts "BLOCKED!"
          else
            comp_find
            #puts "ONE"
          end
        else
          comp_find
          #puts "TWO"
        end
      end

def comp_find
    only_comp_valued = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @comp_sign }}
    count_of_each = only_comp_valued.map { |count_the_items_in_hash| count_the_items_in_hash.count }
      if count_of_each.include?(2) == true
        indexed_hashed = Hash[count_of_each.map.with_index.to_a]
        indexed_value = indexed_hashed[2]
          if @winning_propositions[indexed_value].has_value?(nil)
              nil_valued = @winning_propositions[indexed_value].select { |key, value| value == nil }
              the_symbol = nil_valued.first.first
              #@winning_propositions[indexed_value][the_symbol] = @comp_sign
              @possible_places[the_symbol] = @comp_sign

        #changes the winning prop values in parallel
          list_of_matching_arrays=@winning_propositions.select { |key, value| key.to_s.match(the_symbol.to_s) }
            list_of_matching_arrays.each do |change_hash_value|
               change_hash_value[the_symbol] = @comp_sign
             end

              puts @comp_name + " made the move: #{the_symbol}"
          puts "Lucy"
          display_game_board
           #print @winning_propositions
          else
            random_move
            #puts "THREE"
          end
        else
          random_move
          #puts "FOUR"
        end
  end

  def comp_win
    #fix this, why not reading from prior def correctly?!!!!!!!!!!!!
            @user_sign == "X" ? @comp_sign = "O" : "X"

      a = @winning_propositions.map { |each_hash| each_hash.select { |key, value| value == @comp_sign } }
      b = a.map { |count_the_items_in_hash| count_the_items_in_hash.count }
      b.each { |number_count| puts 'I, Watson, have won.  Better luck next time. :)' if number_count == 3 }
      b.each { |number_count| exit if number_count == 3 }
  end

end
