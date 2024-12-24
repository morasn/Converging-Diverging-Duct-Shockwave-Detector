function [P0, T0, Pe, R, Di, Dt, De, Lc, Ld] = Input_SI_Conversion(P0,T0,Pe, P_u,T_u,R,R_u,Di,Dt,De,D_u,Lc,Ld,L_u)
%% Inputs function for the duct flow calculator that converts the inputs to SI units for further calculations.
% Inputs:
% P0: Pressure at the inlet
% T0: Temperature at the inlet
% Pe: Pressure at the exit
% P_u: Pressure unit
% T_u: Temperature unit
% Pe_u: Exit pressure unit
% R: Gas constant
% Di: Inner diameter of the duct
% Dt: Throat diameter of the duct
% De: Exit diameter of the duct
% D_u: Diameter unit
% Lc: Length of the converging section of the duct
% Ld: Length of the diverging section of the duct
% L_u: Length unit


% Total pressure input and conversion
if P_u == "kPa"
    P0 = P0 * 1e3; % Corrected multiplier
	Pe = Pe * 1e3; 
elseif P_u == "MPa"
    P0 = P0 * 1e6; % Corrected multiplier
	Pe = Pe * 1e6; 
elseif P_u == "bar"
    P0 = P0 * 1e5; % Corrected multiplier
	Pe = Pe * 1e5; 
elseif P_u == "Psi"
    P0 = P0 * 6894.76; % Corrected multiplier
	Pe = Pe * 6894.76; 
elseif P_u == "ksi"
    P0 = P0 * 6.89476e6; % Corrected multiplier
	Pe = Pe * 6.89476e6; 
end

% Total temperature input and conversion
if T_u == "°C"
    T0 = T0 + 273.15;
elseif T_u == "°F"
    T0 = (T0 - 32) * 5/9 + 273.15;
end


% Gas constant input and conversion
if R_u == "kJ/kgK"
    R = R * 1e3; % Corrected multiplier
end

% Diameter inputs and conversions
Di = convert_length(Di, D_u);
Dt = convert_length(Dt, D_u);
De = convert_length(De, D_u);

% Length inputs and conversions
Lc = convert_length(Lc, L_u);
Ld = convert_length(Ld, L_u);

end

function val_m = convert_length(val, unit)
    % Conversion function for lengths
    switch unit
        case "mm"
            val_m = val * 1e-3; % Corrected multiplier
        case "cm"
            val_m = val * 1e-2;
        case "in"
            val_m = val * 0.0254;
        case "ft"
            val_m = val * 0.3048;
        otherwise
            val_m = val; % Assume input in meters if no conversion needed
    end
end

