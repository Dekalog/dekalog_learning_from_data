clear all

load in.dta
load out.dta

% non-linear transforms
y_in = in(:,3) ;
in_sample_data = [ ones(size(in,1),1) in(:,1) in(:,2) in(:,1).^2 in(:,2).^2 in(:,1).*in(:,2) abs(in(:,1).-in(:,2)) abs(in(:,1).+in(:,2)) ] ;
y_out = out(:,3) ; 
out_sample_data = [ ones(size(out,1),1) out(:,1) out(:,2) out(:,1).^2 out(:,2).^2 out(:,1).*out(:,2) abs(out(:,1).-out(:,2)) abs(out(:,1).+out(:,2)) ] ;

% psuedo-inverse for linear regression
% w = ( inv( X' * X ) * X' ) * y ; the "classic" way
% but w = ( ( X' * X ) \ X' ) * y ;
% is quicker and recommended
% formula for regularised regression is w = ( ( X' * X + lambda I ) \ X' ) * y ;
k = -3 ;
lambda = 10^k ;
w = ( ( in_sample_data' * in_sample_data + lambda .* eye( size(in_sample_data' * in_sample_data) ) ) \ in_sample_data' ) * y_in ;

% do the classification
y_in_class = sign( in_sample_data * w ) ;
y_out_class = sign( out_sample_data * w ) ;

% errors
e_in = mean( abs( y_in_class .- y_in )./2 ) ;
e_out = mean( abs( y_out_class .- y_out )./2 ) ;

% euclidean distances
a = sqrt( (0.01 - e_in)^2 + (0.02 - e_out)^2 )
b = sqrt( (0.02 - e_in)^2 + (0.04 - e_out)^2 )
c = sqrt( (0.02 - e_in)^2 + (0.06 - e_out)^2 )
d = sqrt( (0.03 - e_in)^2 + (0.08 - e_out)^2 )
e = sqrt( (0.03 - e_in)^2 + (0.10 - e_out)^2 )
