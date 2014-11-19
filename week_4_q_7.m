clear all

N = 1000000 ;
f_x = zeros( N , 2 ) ;
g_xa = zeros( N , 1 ) ;
g_xb = zeros( N , 1 ) ;
g_xc = zeros( N , 2 ) ;
g_xd = zeros( N , 1 ) ;
g_xe = zeros( N , 2 ) ;

for ii = 1 : N

X = ( rand(2,1) .- 0.5 ) .* 2 ;
f_x(ii,:) = sin( pi .* X )' ;

g_xa(ii) = mean( f_x(ii,:) ) ;

g_xb(ii) = ( ( X' * X ) \ X' ) * f_x(ii,:)' ;

g_xc(ii,:) = ( ( [ X' ; ones(1,2) ] * [ X ones(2,1) ] ) \ [ X' ; ones(1,2) ] ) * f_x(ii,:)' ;

g_xd(ii) = ( ( (X.^2)' * X.^2 ) \ (X.^2)' ) * f_x(ii,:)' ;

g_xe(ii,:) = ( ( [ (X.^2)' ; ones(1,2) ] * [ X.^2 ones(2,1) ] ) \ [ (X.^2)' ; ones(1,2) ] ) * f_x(ii,:)' ;

end

g_xa_bar = mean( g_xa ) ;
g_xb_bar = mean( g_xb ) ;
g_xc_bar = mean( g_xc ) ;
g_xd_bar = mean( g_xd ) ;
g_xe_bar = mean( g_xe ) ;

g_xa_os = ( g_xa .- g_xa_bar ).^2 .+ ( g_xa_bar .- f_x ).^2 ;
 
g_xb_os = ( g_xb .* f_x .- g_xb_bar .* f_x ).^2 .+ ( g_xb_bar .* f_x .- f_x ).^2 ;

g_xc_os = ( (g_xc(:,1) .* f_x .+ g_xc(:,2)) .- (g_xc_bar(:,1) .* f_x .+ g_xc_bar(:,2)) ).^2 .+ ( (g_xc_bar(:,1) .* f_x .+ g_xc_bar(:,2)) .- f_x ).^2 ;

g_xd_os = ( g_xd .* (f_x.^2) .- g_xd_bar .* (f_x.^2) ).^2 .+ ( g_xd_bar .* (f_x.^2) .- f_x ).^2 ;

g_xe_os = ( (g_xc(:,1) .* (f_x.^2) .+ g_xc(:,2)) .- (g_xc_bar(:,1) .* (f_x.^2) .+ g_xc_bar(:,2)) ).^2 .+ ( (g_xc_bar(:,1) .* (f_x.^2) .+ g_xc_bar(:,2)) .- f_x ).^2 ;

gxa_os = mean( g_xa_os(:) )
gxb_os = mean( g_xb_os(:) )
gxc_os = mean( g_xc_os(:) )
gxd_os = mean( g_xd_os(:) )
gxe_os = mean( g_xe_os(:) )


