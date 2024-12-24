function [] = Properties_Plot(Property,Property_Val, Property_Unit, x, Unit_x,fig)
    %% Plot the property accross the length of the duct
    % Inputs:
    % Property: Property to be plotted
    % Unit: Unit of the property
    % x: x-axis values
    % fig: Figure handle
    
	cla(fig); % Clear the figure
	xlabel(fig, strcat('Length of the Duct (', Unit_x, ')')); % Label for x-axis
	
	if Property ~= "Duct Geometry"
    
    	plot(fig, x, Property_Val,'LineWidth', 2, 'Color', 'b'); % Plot the property
    	
    	if Property == "Mach Number"
        	ylabel(fig, 'Mach Number'); % Label for y-axis
    	else
        	ylabel(fig, strcat(Property, ' (', Property_Unit, ')')); % Label for y-axis
    	end
    	axis(fig,"normal") ; % Set the axis to normal
	else
	    R = Property_Val/2; % Radius of the duct
    
		hold(fig,'on'); % Hold the figure
    	plot(fig, x, R,'LineWidth', 2, 'Color', 'b'); % Plot the positive duct
    	plot(fig, x, -R,'LineWidth', 2, 'Color', 'b'); % Plot the negative duct
		axis(fig,"normal") ; % Set the axis to normal
    	hold(fig,"off") ; % Release the figure
		ylabel(fig, strcat(Property, ' (', Property_Unit, ')')); % Label for y-axis
end