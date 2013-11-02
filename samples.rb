@winning_propositions = [{a1:@a1, a2:@a2, a3:@a3},{b1:@b1, b2:@b2, b3:@b3}]
@winning_propositions = [{a1:"O", a2:"X", a3:"O"},{b1:@b1, b2:"O", b3:@b3}]

@possible_places = {a1: @a1,a3: @a3, c1: @c1,c3: @c3}

@winning_propositions = [{a1:@a1, a2:@a2, a3:@a3},{b1:@b1, b2:@b2, b3:@b3},{c1:@c1, c2:@c2, c3:@c3},{a1:@a1, b1:@b1, c1:@c1},{a2:@a1, b2:@b2, c2:@c2},{a3:@a3, b3:@b3, c3:@c3},{a1:@a1, b2:@b2, c3:@c3},{a3:@a3, b2:@b2, c1:@c3}]
@winning_propositions = [{:a1=>"X", :a2=>nil, :a3=>"X"}, {:b1=>nil, :b2=>"O", :b3=>"O"}, {:c1=>"O", :c2=>nil, :c3=>"X"}, {:a1=>"X", :b1=>nil, :c1=>"O"}, {:a2=>nil, :b2=>"O", :c2=>nil}, {:a3=>"X", :b3=>"O", :c3=>"X"}, {:a1=>"X", :b2=>"O", :c3=>"X"}, {:a3=>"X", :b2=>"O", :c1=>"O"}]

@possible_places = {a1: "X",a2: "O",a3: "X",b1: @b1,b2: @b2,b3: @b3,c1: @c1,c2: @c2,c3: @c3}

