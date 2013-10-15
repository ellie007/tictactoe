load 'tictactoedef.rb'

@comp_name = "Watson"

puts 'Hello, I\'m Watson, let\'s play Tic Tac Toe!  What is your name?'
@user_name = gets.chomp
puts "Great " + @user_name + ", do you want to be X's or O's?"

    if gets.chomp.upcase == "O"
      @user_sign = "O"
      @comp_sign = "X"
    else
      @user_sign = "X"
      @comp_sign = "O"
    end

puts 'Okay ' + @user_name + ', you\'ll be ' + @user_sign + '.  Please choose where you want to go.'



n = TicTacToe.new

n.display_game_board
n.user_turn



