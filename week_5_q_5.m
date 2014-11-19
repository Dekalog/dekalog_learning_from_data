clear all

u = 1 ;
v = 1 ;
E = ( u * exp(v) - 2 * v * exp(-u) )^2 ;

iter = 0 ;

while E > 10^-14

iter = iter + 1 ;

dE_du = 2 * ( exp(v) + 2 * v * exp(-u) ) * ( u * exp(v) -2 * v * exp(-u) ) ;
dE_dv = 2 * ( u * exp(v) - 2 * v * exp(-u) ) * ( u * exp(v) - 2 * exp(-u) ) ;

% update
u = u - 0.1 * dE_du ;
v = v - 0.1 * dE_dv ;

% get new E
E = ( u * exp(v) - 2 * v * exp(-u) )^2 ;

end
