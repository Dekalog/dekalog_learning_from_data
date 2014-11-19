clear all

N = 100 ; % to be altered accordingly
N_out = 10000 ;
learning_rate = 0.01 ;
cross_entropy_error = zeros( 100 , 1 ) ;
all_epochs = zeros( 100 , 1 ) ;

for yy = 1 : 100

% generate the data
% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x1 = ( rand( N , 1 ) .- 0.5 ) .* 2 ; x2 = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

% randomly choose two more points for separating line
x_axis = ( rand( 2 , 1 ) .- 0.5 ) .* 2 ; y_axis = ( rand( 2 , 1 ) .- 0.5 ) .* 2 ;

% ensure the separating line is not vertical for ease of label classification
if ( x_axis(1) == x_axis(2) )
x_axis(1) = x_axis(1) * 0.5 ;
end

% fit a straight line to these two separating points

% Formulating a matrix for solving for least squares estimate
X = [ x_axis ones( 2 , 1 ) ] ;
alpha = inv( X' * X ) * X' * y_axis ; % solving for m and c

% allocate points on or above line to +ve class
pos = ( x2 >= alpha(1).*x1.+alpha(2) ) ;
neg = ( x2 < alpha(1).*x1.+alpha(2) ) .* -1 ;
y = pos .+ neg ;

%*********************************************************
% visualise the points
%[ i_plus j ] = find( y == 1 ) ; % get index for +1
%[ i_minus j ] = find( y == -1 ) ; % get index for -1
%plot( x1(i_plus) , x2(i_plus) , 'x', x1(i_minus) , x2(i_minus) , "@11" ) ; % plot +1 points as blue x, plot -1 points as red +
%*********************************************************

% now do logistic regression 
w = zeros( 3 , 1 ) ;
% create a data set matrix N by 3
data_set = [ ones( N , 1 ) x1 x2 ] ;

stop_criteria = 1 ;
epoch = 0 ;

while stop_criteria >= 0.01

w_prev = w ;

for ii = 1 : N

% randomise for SGD
ix = randperm( N ) ;
data_set = data_set( ix , : ) ;
y = y( ix ) ;

gradient = -( y(ii) * data_set( ii , : ) ./ ( 1 .+ exp( y(ii) * data_set(ii,:) * w ) ) ) ;
w = w - learning_rate * gradient' ;

end

epoch = epoch + 1 ;
stop_criteria = norm( w_prev .- w ) ;

end % while

all_epochs(yy) = epoch ;

% generate the out of sample data
% get N_out uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x1_out = ( rand( N_out , 1 ) .- 0.5 ) .* 2 ; x2_out = ( rand( N_out , 1 ) .- 0.5 ) .* 2 ;

% allocate points on or above line to +ve class
pos_out = ( x2_out >= alpha(1).*x1_out.+alpha(2) ) ;
neg_out = ( x2_out < alpha(1).*x1_out.+alpha(2) ) .* -1 ;
y_out = pos_out .+ neg_out ;
data_set_out = [ ones( N_out , 1 ) x1_out x2_out ] ;

cross_entropy_error(yy) = mean( log( 1 .+ exp( -y_out .* data_set_out * w ) ) ) ;

end % yy

mean_epoch = mean( all_epochs )
mean_error = mean( cross_entropy_error )
