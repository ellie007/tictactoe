load 'tictactoedef.rb'

n = TicTacToe.new

puts 'Hello, I\'m ' + n.comp_name + ', let\'s play Tic Tac Toe!  What is your name?'

puts "Great " + n.user_name1 + ", do you want to be X's or O's?"

puts 'Okay ' + n.user_name2 + ', you\'ll be ' + n.user_sign + '.  Please choose where you want to go.'

puts 'The game board is the following, please remember!'
puts ' a1 | a2 | a3'
puts " --- --- ---"
puts ' b1 | b2 | b3'
puts " --- --- ---"
puts ' c1 | c2 | c3'

n.game_board

while n.comp_win != true do
  n.user_turn
  n.comp_turn
end

