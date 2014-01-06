class Admin

  attr_accessor :a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3

  def computer_name
    $computer_name = "Watson"
  end

  def user_name
    $user_name = gets.chomp
  end

  def user_sign
    $user_sign = "X"
  end

  def computer_sign
    $computer_sign = "O"
  end

  def game_board
    $possible_places = {
    a1: @a1,a2: @a2,a3: @a3,
    b1: @b1,b2: @b2,b3: @b3,
    c1: @c1,c2: @c2,c3: @c3
   }
  end

  def display_game_board
    puts "  #{$possible_places[:a1]} | #{$possible_places[:a2]}  | #{$possible_places[:a3]}"
    puts "--- --- ---"
    puts "  #{$possible_places[:b1]} | #{$possible_places[:b2]}  | #{$possible_places[:b3]}"
    puts "--- --- ---"
    puts "  #{$possible_places[:c1]} | #{$possible_places[:c2]}  | #{$possible_places[:c3]}"
  end

  def winning_propositions
    $winning_propositions = [
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

  def declare_computer_move(move)
    $possible_places[move] = $computer_sign
    puts $computer_name + " made the move: #{move}"
    display_game_board
    update_computer_game_board(move)
    #return computer_made_move
    #user_turn
  end

  def update_computer_game_board(move)
    list_of_matching_arrays = $winning_propositions.select { |key, value| key.to_s.match(move.to_s) }
    list_of_matching_arrays.each do |change_hash_value|
      change_hash_value[move] = $computer_sign
    end
  end

  def computer_win
    a = $winning_propositions.map { |each_hash| each_hash.select { |key, value| value == $computer_sign } }
    b = a.map { |count_the_items_in_hash| count_the_items_in_hash.count }
    b.each { |number_count| puts 'I, Watson, have won.  Better luck next time. :)' if number_count == 3 }
    b.each { |number_count| exit if number_count == 3 }
  end

  def draw_game_outcome
    puts "Draw game.  You are formidable competition; good job!" if $possible_places.values.include?(nil) == false
    exit if $possible_places.values.include?(nil) == false
  end

end
