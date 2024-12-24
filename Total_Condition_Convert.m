function [P0x,T0]=Total_Condition_Convert(Pi,Ti,Ma_i,k,Conditions)
    %% Convert static conditions to total conditions.
    % Inputs:
    % Pi: Static pressure at the inlet
    % Ti: Static temperature at the inlet
    % Ma_i: Mach number at the inlet
    % k: Specific gas constant
    % Conditions: Units of the input conditions
    % Outputs:
    % P0x: Total pressure at the inlet
    % T0: Total temperature at the inlet

    if Conditions == "Static"
        % Total pressure input and conversion
        P0x = Pi*((1 + ((k - 1)/2) * Ma_i^2)^(k/(k-1)));
        T0 = Ti*((1+((k-1)/2)*(Ma_i^2)));
    else
        P0x = Pi;
        T0 = Ti;
    end
end
