clear all

u = 1 ;
v = 1 ;
E = ( u * exp(v) - 2 * v * exp(-u) )^2 ;

for ii = 1 : 15

% do u first
dE_du = 2 * ( exp(v) + 2 * v * exp(-u) ) * ( u * exp(v) -2 * v * exp(-u) ) ;
% update
u = u - 0.1 * dE_du ;

% now do v
dE_dv = 2 * ( u * exp(v) - 2 * v * exp(-u) ) * ( u * exp(v) - 2 * exp(-u) ) ;
% update
v = v - 0.1 * dE_dv ;

% get new E
E = ( u * exp(v) - 2 * v * exp(-u) )^2 ;

end
