class TicTacToe

  def display_game_board
    attr_accessor :a1, :a2, :a3, :b1, :b2, :b3, :c1, :c2, :c3
    @possible_places = {
     a1: @a1,a2: @a2,a3: @a3,
     b1: @b1,b2: @b2,b3: @b3,
     c1: @c1,c2: @c2,c3: @c3}


      puts "#{@possible_places[:a1]} | #{@possible_places[:a2]} | #{@possible_places[:a3]}"
      puts "--- --- ---"
      puts "#{@possible_places[:b1]} | #{@possible_places[:b2]} | #{@possible_places[:b3]}"
      puts "--- --- ---"
      puts "#{@possible_places[:c1]} | #{@possible_places[:c2]} | #{@possible_places[:c3]}"
  end

   def user_turn
    input=gets.chomp.to_sym
    @possible_places[input] = 's'
    puts display_game_board
  end


end
