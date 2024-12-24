function [Px, Tx, Py, Ty, Vx, Vy, Asw, D, Dsw, P, T, V] = Output_SI_Conversion(Px,Py,P,Tx,Ty,T,Vx,Vy,V,Asw, D, Dsw,P_u,T_u,D_u)
%% Convert the output values to the user selected units
% Inputs:
% Px, Py: Pressure values
% Tx, Ty: Temperature values
% Vx, Vy: Velocity values
% Asw, Dsw: Area and diameter of shockwave
% P, T, V: Total pressure, temperature and velocity values
% P_u, T_u, D_u: Pressure, temperature and diameter units
% Outputs:
% Px, Py: Pressure values in user selected units
% Tx, Ty: Temperature values in user seleted units
% Vx, Vy: Velocity values in  user selected units
% Asw, Dsw: Area and diameter of shockwave
% P, T, V: Total pressure, temperature and velocity values in user selected units

% Total pressure input and conversion
if P_u == "kPa"
    Px = Px * 1e-3; % Corrected multiplier
    Py = Py * 1e-3;
    P = P .* 1e-3;
elseif P_u == "MPa"
    Px = Px * 1e-6; % Corrected multiplier
    Py = Py * 1e-6;
    P = P .* 1e-6;
elseif P_u == "bar"
    Px = Px * 1e-5; % Corrected multiplier
    Py = Py * 1e-5;
    P = P .* 1e-5;
elseif P_u == "Psi"
    Px = Px / 6894.76; % Corrected multiplier
    Py = Py / 6894.76;
    P = P ./ 6894.76;
elseif P_u == "ksi"
    Px = Px * 1.450e-7; % Corrected multiplier
    Py = Py * 1.450e-7;
    P = P .* 1.450e-7;

end

% Total temperature input and conversion
if T_u == "°C"
    Tx = Tx - 273.15;
    Ty = Ty - 273.15;
    T = T - 273.15;
elseif T_u == "°F"
    Tx = (Tx - 273.15) * 9/5 + 32;
    Ty = (Ty - 273.15) * 9/5 + 32;
    T = (T - 273.15) .* 9/5 + 32;
end

% Diameter inputs and conversions
Vx = convert_length(Vx, D_u);
Vy = convert_length(Vy, D_u);
V = convert_length(V, D_u);
D = convert_length(D, D_u);
Dsw = convert_length(Dsw,D_u);
Asw = convert_Area(Asw, D_u);
end

function val_m = convert_length(val, unit)
    % Conversion function for lengths
    switch unit
        case "mm"
            val_m = val .* 1e3; % Corrected multiplier
        case "cm"
            val_m = val .* 1e2;
        case "in"
            val_m = val .* 39.37;
        case "ft"
            val_m = val .* 3.281;
        otherwise
            val_m = val; % Assume input in meters if no conversion needed
    end
end

function val_m = convert_Area(val,unit)
    switch unit
        case "mm"
            val_m = val .* 1e6; % Corrected multiplier
        case "cm"
            val_m = val .* 1e4;
        case "in"
            val_m = val .* 1550;
        case "ft"
            val_m = val .* 10.763;
        otherwise
            val_m = val; % Assume input in meters if no conversion needed
    end
end