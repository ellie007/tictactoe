class UserLogic < Admin

  def user_turn
    input = gets.chomp.downcase.to_sym
    case input
      when 'a1'.to_sym, 'a2'.to_sym, 'a3'.to_sym, 'b1'.to_sym, 'b2'.to_sym, 'b3'.to_sym, 'c1'.to_sym, 'c2'.to_sym, 'c3'.to_sym
        declare_user_input(input) unless spot_is_occupied(input)
      else
        invalid_user_input
    end
  end

  def spot_is_occupied(input)
    if $possible_places[input] != nil
      puts "Spot is occupied, please choose an empty space."
      user_turn
    else
      declare_user_input(input)
    end
  end

  def invalid_user_input
    puts "Please respond in the format of e.g.; a1, c2, etc."
    user_turn
  end

  def declare_user_input(input)
    $possible_places[input] = $user_sign
    puts "#{$user_name} made the move: #{input}"
    display_game_board
    update_user_game_board(input)
  end

  def update_user_game_board(input)
    list_of_matching_arrays = $winning_propositions.select { |key, value| key.to_s.match(input.to_s) }
    list_of_matching_arrays.each do |change_hash_value|
      change_hash_value[input] = $user_sign
    end
  end

end
