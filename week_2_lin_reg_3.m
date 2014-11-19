clear all

N = 10 ; % to be altered accordingly

iter_record = zeros( 1000 , 1 ) ;

for ii = 1 : 1000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate the new data
% get N uniform random points on the interval [ -1 1 ] x [ -1 1 ]
x_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ; y_axis = ( rand( N , 1 ) .- 0.5 ) .* 2 ;

% create a data set matrix N by 2
training_data_set = [ x_axis y_axis ] ;

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

pos_data_set = training_data_set( pos , : ) ;
neg_data_set = training_data_set( ( y_axis < yEst ) , : ) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% linear regression on data_set and y
X = [ ones( N , 1 ) training_data_set ] ;

% w = ( inv( X' * X ) * X' ) * y ; the "classic" way
% but
w = ( ( X' * X ) \ X' ) * y ;
% is quicker and recommended

% w is now initial weights for perceptron learning

%Bookkeeping
num_neg_examples = size( neg_data_set , 1 ) ;
num_pos_examples = size( pos_data_set , 1 ) ;

% Here we add a column of ones to the examples in order to allow us to learn
% bias parameters.
neg_examples = [ ones( num_neg_examples , 1 ) , neg_data_set ]  ;
pos_examples = [ ones( num_pos_examples , 1 ) , pos_data_set ] ;

% Find the data points that the perceptron has incorrectly classified
% and record the number of errors it makes.
iter = 0 ;

[ mistakes0 , mistakes1 ] = eval_perceptron( neg_examples , pos_examples , w ) ;

num_errs = size( mistakes0 , 1 ) + size( mistakes1 , 1 ) ;

% Iterate until the perceptron has correctly classified all points.
while ( num_errs > 0 )

    iter = iter + 1 ;
    
    random_index_choice = randi( num_errs ) ;
    
    if ( random_index_choice <= size( mistakes0 , 1 ) ) % have chosen a from mistakes0
    
       w = w .- neg_examples( mistakes0( random_index_choice ) , : )' ;
       
    else % have chosen from mistakes1
    
       w = w .+ pos_examples( mistakes1( random_index_choice - size( mistakes0 , 1 ) ) , : )' ;
    
    end

    % Find the data points that the perceptron has incorrectly classified.
    % and record the number of errors it makes.
    [ mistakes0 , mistakes1 ] = eval_perceptron( neg_examples , pos_examples , w ) ;
    num_errs = size( mistakes0 , 1 ) + size( mistakes1 , 1 ) ;

end % end while

iter_record(ii) = iter ;

end

mean( iter_record )
