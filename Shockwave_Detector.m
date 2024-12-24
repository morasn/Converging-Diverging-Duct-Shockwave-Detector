function [iAsw,Ma_x,Ma_y,Px,Py,Tx,Ty,Vx,Vy,Ma_e,P0y,error]  = Shockwave_Detector(k,R,P0x,T0,Pe,A,iAt)
    %% This function calculates the shockwave properties in a converging-diverging duct based on the input parameters
    % k: Specific gas constant
    % R: Gas constant
    % P0x: Total pressure at the inlet
    % T0: Total temperature at the inlet
    % Pe: Pressure at the exit
    % A: Area vector
    % iAt: Index of the throat area
    % Outputs:
    % Asw: Area at the shockwave
    % iAsw: Index of the shockwave area
    % Ma_x: Mach number at the throat
    % Ma_y: Mach number at the shockwave
    % Px: Pressure at the throat
    % Py: Pressure at the shockwave
    % Tx: Temperature at the throat
    % Ty: Temperature at the shockwave
    % Vx: Velocity at the throat
    % Vy: Velocity at the shockwave
    % Ma_e: Mach number at the exit
    % Pe_calc: Calculated pressure at the exit
    % error: Error in the calculated pressure at the exit
    % Te: Temperature at the exit
    % Ve: Velocity at the exit
    % P0y: Total pressure at the shockwave

Ae=A(end); % Exit area
At = A(iAt); % Throat area
for i= length(A):-1:iAt


    Asw_At_fun = @(Ma_x) (A(i)/At)-((1/Ma_x)*(((2/(k+1))*(1+((k-1)/2)*Ma_x^2) )^(((k+1)/(2*(k-1))))));
    Ma_x=fsolve(Asw_At_fun,5);

%   Ma_y_fun = @(Ma_y) (  (Ma_x^2 + (2/(k-1)) ) / ( ((2*k/(k-1)) * Ma_x^2) - 1 ) )-(Ma_y^2); 
%   Ma_y = fsolve(Ma_y_fun, 0.4);
    Ma_y= sqrt((  (Ma_x^2 + (2/(k-1)) ) / ( ((2*k/(k-1)) * Ma_x^2) - 1 ) ));

    P0y = ((( ((k+1)/2) * Ma_x^2)^(k/(k-1)) )*( (1 + ((k-1)/2) * Ma_x^2)^( -k/(k-1) ) )*( ( (2*k/(k+1)) * Ma_x^2 - ( (k-1)/(k+1)))^( -1/(k-1) )))*(P0x);

    A1_A2_fun= @(Ma_e) (Ae/A(i))-(Ma_y/Ma_e)*((1+((k-1)/2)*Ma_e^2)/(1+((k-1)/2)*Ma_y^2))^((k+1)/(2*(k-1)));
    Ma_e = fsolve(A1_A2_fun,0.4);

%     Ath_virtual = Asw/((1/Ma_y)*((( (2/(k+1))*(1+  (  ( (k-1)/2 )*(Ma_y^2) )  ) ))^( (k+1)/(2*(k-1)) )));
%     Asw_Atv_fun = @(Ma_e2) (Ae/Ath_virtual)-((1/Ma_e2)*(((2/(k+1))*(1+((k-1)/2)*Ma_e2^2) )^(((k+1)/(2*(k-1))))));
%     Ma_e2=fsolve(Asw_Atv_fun,0.5);
%     Pe_calc2 = P0y/((1 + ((k - 1)/2) * Ma_e2^2)^(k/(k-1)));

    Pe_calc = P0y/((1 + ((k - 1)/2) * Ma_e^2)^(k/(k-1)));
    error = abs(Pe_calc-Pe)/Pe;

     if error<=0.02
         Asw=A(i);
        break
     end
end

Te=T0/(1+((k-1)/2)*(Ma_e^2));
Ve=Ma_e*(sqrt(k*R*Te));
    

Px =  P0x/((1 + ((k - 1)/2) * Ma_x^2)^(k/(k-1))); 
Py =  P0y/((1 + ((k - 1)/2) * Ma_y^2)^(k/(k-1))); 
 
Tx = T0/(1+((k-1)/2)*(Ma_x^2)); 
Ty = T0/(1+((k-1)/2)*(Ma_y^2)); 
% Ty = Tx*( (1+((k-1)/2)*Ma_x^2) / (1+((k-1)/2)*Ma_y^2) );

Vx=Ma_x*(sqrt(k*R*Tx)); 
Vy=Ma_y*(sqrt(k*R*Ty)); 

% iAsw=find(A==Asw,2);
iAsw=i; % Index of the shockwave area

end