clear al

% g_x = a * x from q4
a = 1.4282 ;

f_x = zeros( 100000 , 2 ) ;
g_x = zeros( 100000 , 2 ) ;
g_bar_x = zeros( 1000 , 2 ) ;

for ii = 1 : 100000
X = ( rand(2,1) .- 0.5 ) .* 2 ;
f_x(ii,:) = sin( pi .* X )' ;
g_x(ii,:) = ( ( ( ( X' * X ) \ X' ) * sin( pi .* X ) ) .* X )' ;
g_bar_x(ii,:) = ( a .* X )' ;
end

bias = ( g_bar_x .- f_x ).^2 ; bias = mean( bias(:) )
var = ( g_x .- g_bar_x ).^2 ; var = mean( var(:) )


