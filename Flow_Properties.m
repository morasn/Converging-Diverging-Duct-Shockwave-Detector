function [Ma_dist,P_dist,T_dist,V_dist]=Flow_Properties(k,R,P0x,T0,iAsw,iAt,A,Ma_x,Px,Tx,Vx,Ma_y,P0y)
%% Flow_Properties Function to calculate the flow properties of the duct flow based on the input parameters.
% Inputs:
% k: Specific heat ratio
% R: Gas constant
% P0x: Total pressure upstream of the shock wave
% T0: Total temperature upstream of the shock wave
% iAsw: Index of the shock wave location
% iAt: Index of the throat location
% A: Area distribution of the duct
% Ma_x: Mach number downstream of the shock wave
% Px: Pressure downstream of the shock wave
% Tx: Temperature downstream of the shock wave
% Vx: Velocity downstream of the shock wave
% Ma_y: Mach number downstream of the shock wave
% P0y: Total pressure downstream of the shock wave
% Outputs:
% Ma_dist: Mach number distribution along the duct
% P_dist: Pressure distribution along the duct
% T_dist: Temperature distribution along the duct
% V_dist: Velocity distribution along the duct

At = A(iAt);
Asw = A(iAsw);
Ma_dist=zeros(1,length(A)); 
P_dist=zeros(1, length(A)); 
T_dist=zeros(1, length(A)); 
V_dist=zeros(1, length(A)); 


for i = 1:(iAt-1)

    A_At_fun = @(Ma) (A(i)/At)-((1/Ma)*(((2/(k+1))*(1+((k-1)/2)*Ma^2) )^(((k+1)/(2*(k-1))))));

    Ma_dist(i)=fsolve(A_At_fun,0.5);

    P_dist(i)= P0x/((1 + ((k - 1)/2) * Ma_dist(i)^2)^(k/(k-1)));

    T_dist(i)= T0/(1+((k-1)/2)*(Ma_dist(i)^2));

    V_dist(i)= Ma_dist(i)*(sqrt(k*R*T_dist(i)));
end

Ma_dist(iAt)= 1;
P_dist(iAt)= P0x/((1 + ((k - 1)/2) * 1^2)^(k/(k-1)));
T_dist(iAt)= T0/(1+((k-1)/2)*(1^2));
V_dist(iAt)= 1*(sqrt(k*R*T_dist(iAt)));

for i = (iAt+1):(iAsw-1)

    A_At_fun = @(Ma) (A(i)/At)-((1/Ma)*(((2/(k+1))*(1+((k-1)/2)*Ma^2) )^(((k+1)/(2*(k-1))))));

    Ma_dist(i)=fsolve(A_At_fun,1.5);

    P_dist(i)= P0x/((1 + ((k - 1)/2) * Ma_dist(i)^2)^(k/(k-1)));

    T_dist(i)= T0/(1+((k-1)/2)*(Ma_dist(i)^2));

    V_dist(i)= Ma_dist(i)*(sqrt(k*R*T_dist(i)));
end

Ma_dist(iAsw)=Ma_x;
P_dist(iAsw)= Px;
T_dist(iAsw)= Tx;
V_dist(iAsw)= Vx;
Atv = Asw/((1/Ma_y)*((( (2/(k+1))*(1+  (  ( (k-1)/2 )*(Ma_y^2) )  ) ))^( (k+1)/(2*(k-1)) )));

for i = (iAsw+1):length(A)

    A_At_fun = @(Ma) (A(i)/Atv)-((1/Ma)*(((2/(k+1))*(1+((k-1)/2)*Ma^2) )^(((k+1)/(2*(k-1))))));

    Ma_dist(i)=fsolve(A_At_fun,0.5);

    P_dist(i)= P0y/((1 + ((k - 1)/2) * Ma_dist(i)^2)^(k/(k-1)));

    T_dist(i)= T0/(1+((k-1)/2)*(Ma_dist(i)^2));

    V_dist(i)= Ma_dist(i)*(sqrt(k*R*T_dist(i)));
end


