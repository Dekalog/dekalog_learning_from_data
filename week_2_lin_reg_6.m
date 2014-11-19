clear all

N = 1000 ;

out_of_sample_fraction_incorrect = zeros( 1000 , 1 ) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate the new data
% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x1 = ( rand( N , 1 ) .- 0.5 ) .* 2 ; x2 = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

labels = sign( x1.^2 .+ x2.^2 .- 0.6 ) ;

random_index = randperm( N , 100 ) ;

labels( random_index ) = labels( random_index ) .* -1 ;

% linear regression on non-linear features of x1, x2
X = [ ones( N , 1 ) x1 x2 x1.*x2 x1.^2 x2.^2 ] ;

% w = ( inv( X' * X ) * X' ) * y ; the "classic" way
% but
w = ( ( X' * X ) \ X' ) * labels ;
% is quicker and recommended

for ii = 1 : 1000

% generate out of sample data
x1 = ( rand( N , 1 ) .- 0.5 ) .* 2 ; x2 = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

labels = sign( x1.^2 .+ x2.^2 .- 0.6 ) ;

random_index = randperm( N , 100 ) ;

labels( random_index ) = labels( random_index ) .* -1 ;

% apply the hypothesis
y_lin_est = sign( [ ones( N , 1 ) x1 x2 x1.*x2 x1.^2 x2.^2 ] * w ) ;

out_of_sample_fraction_incorrect(ii) = sum( labels ~= y_lin_est ) / 1000 ;

end

mean( out_of_sample_fraction_incorrect )

% visualise the points

[ i_plus j ] = find( labels == 1 ) ; % get index for +1
[ i_minus j ] = find( labels == -1 ) ; % get index for -1

plot( x1(i_plus) , x2(i_plus) , 'x', x1(i_minus) , x2(i_minus) , "@11" ) ; % plot +1 points as blue x, plot -1 points as red +
