function [A,D,x,Index_Throat] = Duct_Area(Di,Dt,De,Lc,Ld, func)
    %% The function calculates the area of the duct based on the duct dimensions as follows:
    % Di: Inner diameter of the duct
    % Dt: Throat diameter of the duct
    % De: Exit diameter of the duct
    % Lc: Length of the converging section of the duct
    % Ld: Length of the diverging section of the duct
    % func: Function to be used for the calculation of the area
	
	Ri = Di/2; Rt = Dt/2; Re = De/2; 
	
	Index_Throat = 50; Size_Diver = 200;
	x_converging = linspace(0,Lc,Index_Throat) ; 
    x_diverging = linspace(Lc,Lc+Ld,Size_Diver);
	 
    if func == "Linear"
        % Converging Section: Linear decrease in radius
        R_converging = Ri + (Rt - Ri) .* x_converging / Lc;
        % Diverging Section: Linear increase in radius
        R_diverging = Rt + (Re - Rt) .* (x_diverging - Lc) / Ld;
    
    elseif func == "Quadratic"
            % Converging Section: Quadratic decrease in radius
            a1 = (Rt - Ri) / Lc^2; % Quadratic coefficient
            R_converging = Ri + a1 * x_converging.^2;

            % Diverging Section: Quadratic increase in radius
            a2 = (Re - Rt) / Ld^2; % Quadratic coefficient
            x_diverging_rel = x_diverging - Lc; % Relative position for diverging section
            R_diverging = Rt + a2 * x_diverging_rel.^2;
    end
    x = [x_converging x_diverging];
    R = [R_converging R_diverging];
    A = pi * R.^2;
    D = R*2;

end