clear all

% set up recording vectors
coin_tosses= zeros( 1000 , 10 ) ;
v1 = zeros( 100000 , 1 ) ;
v_rand = zeros( 100000 , 1 ) ;
v_min = zeros( 100000 , 1 ) ;

for ii = 1 : 100000

% toss the coins
coin_tosses = ( rand(1000,10) > 0.5 ) ;

% c1 is the first coin, i.e. the first row of above matrix
v1(ii) = sum( coin_tosses( 1 , : ) ) / 10 ;

% c_rand, a random choice
v_rand(ii) = sum( coin_tosses( randi(1000) , : ) ) / 10 ;

% the coin with the min heads
v_min(ii) = min( sum( coin_tosses , 2 ) ) / 10 ;

end

ave_v1 = mean( v1 ) ;
ave_v_rand = mean( v_rand ) ;
ave_v_min = mean( v_min ) ;

hist( ave_v1 )
