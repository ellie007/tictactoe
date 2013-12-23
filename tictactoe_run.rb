load 'admin_logic.rb'
load 'comp_logic.rb'
load 'user_logic.rb'

n = TicTacToe.new

puts "Hello, I\'m " + n.computer_name + ", let\'s play Tic Tac Toe!  What is your name?"

puts "Great " + n.user_name + ", you\'ll be " + n.user_sign + ".  Please choose where you want to go."

puts 'The game board is the following, please remember!'
puts ' a1 | a2 | a3'
puts " --- --- ---"
puts ' b1 | b2 | b3'
puts " --- --- ---"
puts ' c1 | c2 | c3'

n.user_sign
n.computer_sign
n.game_board
n.winning_propositions

while n.computer_win != true do
  n.user_turn
  n.draw_game_outcome
  n.player_first_turn_check?
  n.draw_game_outcome
end

