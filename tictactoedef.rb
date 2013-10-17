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

  def user_turn
    input=gets.chomp.to_sym
    @possible_places[input] = @user_sign
    puts @user_name + " made the move: #{input}"
    display_game_board
  end

  def comp_turn
        #fix this, why not reading from prior def correctly?!!!!!!!!!!!!
            if @user_sign == 'X'
              @comp_sign = 'O'
            else
              @comp_sign = 'X'
            end
  #comp find a spot with one already
    hash_to_array = @possible_places.to_a
    only_comp_sign_valued_hash = hash_to_array.select {|key, value| value==@comp_sign}
    only_comp_sign_valued_hash

  #comp find random place
    hash_to_array = @possible_places.to_a
    only_nil_valued_hash = hash_to_array.select {|key, value| value==nil}
    random_array_hash_value = only_nil_valued_hash.sample
    move = random_array_hash_value.first
    @possible_places[move] = @comp_sign
    puts @comp_name + " made the move: #{move}"
    display_game_board
  end

  def comp_win

  end

end
