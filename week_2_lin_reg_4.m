clear all

N = 1000 ;

fraction_incorrect = zeros( N , 1 ) ;

for ii = 1 : 1000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate the new data
% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x1 = ( rand( N , 1 ) .- 0.5 ) .* 2 ; x2 = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

labels = sign( x1.^2 .+ x2.^2 .- 0.6 ) ;

random_index = randperm( N , 100 ) ;

labels( random_index ) = labels( random_index ) .* -1 ;

% linear regression on x1, x2 and labels
X = [ ones( N , 1 ) x1 x2 ] ;

% w = ( inv( X' * X ) * X' ) * y ; the "classic" way
% but
w = ( ( X' * X ) \ X' ) * labels ;
% is quicker and recommended

% now apply this to classify
y_lin_est = sign( [ ones( N , 1 ) x1 x2 ] * w ) ;

fraction_incorrect(ii) = sum( labels ~= y_lin_est ) / N ;

end

mean( fraction_incorrect )

% visualise the points

[ i_plus j ] = find( labels == 1 ) ; % get index for +1
[ i_minus j ] = find( labels == -1 ) ; % get index for -1

plot( x1(i_plus) , x2(i_plus) , 'x', x1(i_minus) , x2(i_minus) , "@11" ) ; % plot +1 points as blue x, plot -1 points as red +
