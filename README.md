# Shockwave Location Detection in a Converging-Diverging Duct

## Project Overview
This project focuses on developing a MATLAB tool to evaluate the location of a traveling shockwave in a converging-diverging (CD) duct. The tool allows users to input various parameters, simulate the conditions within the duct, and visualize the results.

### Features
- **User-Defined Inputs**: 
  - Exit pressure, inlet pressure, temperature, and Mach number.
  - Fluid properties (specific heat ratio \( k \) and gas constant \( R \)).
  - Geometric configuration of the duct (length of each section, inlet, throat, and outlet diameters).
  - Wall function options: linear or quadratic.
- **Unit Flexibility**: 
  - Accepts inputs in both SI and Imperial units.
- **Outputs**:
  - Pressure, temperature, velocity, and Mach number before and after the shockwave.
  - Visualization of these properties along the duct.
  - Geometry plot of the CD duct.

### Outputs
1. **Plots**:
   - Mach number, pressure, and temperature distributions along the duct.
   - Duct geometry visualization.
2. **Tabular Data**:
   - Key parameters before and after the shockwave.

## Team Contributions
This project was completed as part of a group effort. Each member played a critical role in its success:
- **Omar (Team Leader)**: Responsible for developing the GUI and integrating the code.
- **Loka**: Focused on validation of the results.
- **Shady**: Developed unit conversion utilities and verified simulation results.
- **Hamza**: Developed the algorithm for detecting teh shockwave using iterative methods.
- **Dr. Omar Abdulaziz**: Guided the project and provided valuable insights throughout the development process.

### Bonus Feature
The tool also includes a bonus feature to plot fluid properties and Mach number variations throughout the CD duct, enhancing the understanding of flow dynamics.

## Repository Contents
- `Shockwave_Calc.mlapp`: The primary script for running the tool.
- `Duct_Area.m`: Calculates the area of the duct based on the duct dimensions.
- `Flow_Properties.m`:  Calculate the flow properties of the duct flow based on the input parameters.
- `Inputs_SI_Conversions.m`: Inputs function for the duct flow calculator that converts the inputs to SI units for further calculations.
- `Output_SI_Conversion.m`: Convert the output values to the user selected units.
- `Properties_Plot.m`: Plot the property accross the length of the duct.
- `Shockwave_Detector.m`:  Calculates the shockwave properties in a converging-diverging duct based on the input parameters.
- `SWcheck.m`: Shockwave detection function using the rpc criterion.
- `Total_Condition_Convert.m`: Convert static conditions to total conditions.

## Installation and Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/shockwave-cd-duct.git
   ```
2. Open MATLAB and navigate to the project directory.
3. Run `Shockwave_Calc.mlapp` to launch the GUI.
4. Follow the instructions to input parameters and view results.

## Acknowledgments
We express our gratitude to **Dr. Omar Abdulaziz** for their mentorship and guidance, and to all team members for their dedication and collaboration throughout this project.
