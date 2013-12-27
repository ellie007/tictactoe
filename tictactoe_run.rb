load 'admin_logic.rb'
load 'computer_logic.rb'
load 'user_logic.rb'


class TicTacToe < Admin
  attr_reader :admin_object, :computer_object, :user_object

  def initialize
    @admin_object = Admin.new
    @computer_object = ComputerLogic.new
    @user_object = UserLogic.new
  end
end

new_game = TicTacToe.new

puts "Hello, I\'m " + new_game.admin_object.computer_name + ", let\'s play Tic Tac Toe!  What is your name?"

puts "Great " + new_game.admin_object.user_name + ", you\'ll be " + new_game.admin_object.user_sign + ".  Please choose where you want to go."

puts 'The game board is the following, please remember!'
puts ' a1 | a2 | a3'
puts " --- --- ---"
puts ' b1 | b2 | b3'
puts " --- --- ---"
puts ' c1 | c2 | c3'

new_game.admin_object.user_sign
new_game.admin_object.computer_sign
new_game.admin_object.game_board
new_game.admin_object.winning_propositions

while new_game.admin_object.computer_win != true do
  new_game.user_object.user_turn
  new_game.admin_object.draw_game_outcome
  new_game.computer_object.player_first_turn_check?
  new_game.admin_object.draw_game_outcome
end


