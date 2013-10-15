load 'tictactoedef.rb'

n = TicTacToe.new

puts 'Hello, I\'m ' + n.comp_name + ', let\'s play Tic Tac Toe!  What is your name?'

puts "Great " + n.user_name1 + ", do you want to be X's or O's?"

puts 'Okay ' + n.user_name2 + ', you\'ll be ' + n.user_sign + '.  Please choose where you want to go.'



n.display_game_board
n.user_turn
n.comp_turn



