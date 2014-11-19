clear all

x1 = -1:0.1:1 ;
x2 = -1:0.1:1 ;
w = [ 0 -1 1 ] ;

z = zeros( length(x1) , length(x2) ) ;

for xx = 1 : length(x1)

  for yy = 1 : length(x2)
  
  z(xx,yy) = w(1)*1 + w(2)*x1(xx)^2 + w(3)*x2(yy)^2 ;
  
  end
  
end

surf( z ) ; xlabel('x1') ;ylabel('x2') ; zlabel('z') ; 
