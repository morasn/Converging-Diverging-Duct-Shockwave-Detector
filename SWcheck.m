function [check] = SWcheck(A,Index_Throat,k,P0x,Pe)
%% Shockwave detection function using the rpc criterion
% Inputs:
% A: Area vector
% Index_Throat: Index of the throat area
% k: Specific heat ratio
% P0x: Total pressure at the inlet
% Pe: Pressure at the exit
% Outputs:
% check: Output regime of the nozzle

Ae = A(end); % Exit area
At = A(Index_Throat); % Throat area
Ae_At_fun = @(Ma) (Ae/At)-((1/Ma)*(((2/(k+1))*(1+((k-1)/2)*Ma^2) )^(((k+1)/(2*(k-1))))));
Ma_super=fsolve(Ae_At_fun,2.5);
Ma_sub=fsolve(Ae_At_fun,0.5);

rpc1= 1/((1 + ((k - 1)/2) * Ma_sub^2)^(k/(k-1)));

rpc3= 1/((1 + ((k - 1)/2) * Ma_super^2)^(k/(k-1)));

rpc2= rpc3*((((2*k)/(k+1))*(Ma_super^2))-((k-1)/(k+1)));

rp_e = Pe/P0x;

if rp_e < rpc1 && rp_e > rpc2
    check = 1; % shock regime
elseif rp_e >= rpc1
    check = 2; % venturi regime
elseif rp_e == rpc2
    check = 3; % shock wave at exit 
elseif rp_e < rpc2
    check = 4; % overexpanded regime
elseif rp_e <= rpc3
    check = 5; % underexpanded regime
end





