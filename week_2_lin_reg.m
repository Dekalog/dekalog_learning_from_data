clear all

N = 100 ; % to be altered accordingly

fraction_incorrect = zeros( 1000 , 1 ) ;

for ii = 1 : 1000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate the new data
% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ; y_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

% create a data set matrix N by 2
data_set = [ x_axis y_axis ] ;

% randomly choose two more points for separating line
x_axis_1 = ( rand( 2 , 1 ) .- 0.5 ) .* 2 ; y_axis_1 = ( rand( 2 , 1 ) .- 0.5 ) .* 2 ;

% ensure the separating line is not vertical for ease of label classification
if ( x_axis_1(1) == x_axis_1(2) )
x_axis_1(1) = x_axis_1(1) * 0.5 ;
end

% fit a straight line to these two separating points

% Formulating a matrix for solving for least squares estimate
X = [ x_axis_1 ones( 2 , 1 ) ] ;
alpha = inv( X' * X ) * X' * y_axis_1 ; % solving for m and c

% construct a straight line
yEst = alpha(1) .* x_axis .+ alpha(2) ;

% allocate points on or above line to +ve class
pos = ( y_axis >= yEst ) ;
neg = ( y_axis < yEst ) .* -1 ;
y = pos .+ neg ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% linear regression on data_set and y
X = [ ones( N , 1 ) data_set ] ;

% w = ( inv( X' * X ) * X' ) * y ; the "classic" way
% but
w = ( ( X' * X ) \ X' ) * y ;
% is quicker and recommended

% now apply this to classify
y_lin_est = sign( [ ones( N , 1 ) data_set ] * w ) ;

fraction_incorrect(ii) = sum( y ~= y_lin_est ) / N ;

end

mean( fraction_incorrect )
