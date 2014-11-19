clear all

f_x = sin( pi .* (-1:0.1:1) ) ;

a = zeros( 1000000 , 1 ) ;
X_all = zeros( 100000 , 2 ) ;

for ii = 1 : 1000000
X = ( rand(2,1) .- 0.5 ) .* 2 ;
X_all( ii , : ) = X' ;
y = sin( pi .* X ) ;
a(ii) = ( ( X' * X ) \ X' ) * y ;
%a(ii) = mean( y ) ;
end

g_x = mean( a )

plot( (-1:0.1:1) , f_x , 'b' , X , y , 'r*' ) 
