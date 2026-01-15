% Set default figure appearance so that dark mode doesn't affect figures
set(0, 'DefaultFigureColor', 'w', ...        
       'DefaultAxesColor', 'w', ...          
       'DefaultAxesXColor', 'k', ...         
       'DefaultAxesYColor', 'k', ...         
       'DefaultAxesZColor', 'k', ...         
       'DefaultTextColor', 'k', ...          
       'DefaultAxesTitleFontWeight', 'normal', ...
       'DefaultLegendTextColor', 'k', ...    
       'DefaultLegendColor', 'w');           

% Define spatial domain and kink solution phi(x)
x = linspace(6, -6, 400);
phi = tanh(x);

% Plot kink and anti-kink solutions
figure; hold on;

plot(x,  phi, 'b', 'LineWidth', 2);
plot(x, -phi, 'r', 'LineWidth', 2);

yline( 1, 'g--', 'LineWidth', 2);
yline(-1, 'g--', 'LineWidth', 2);

xlabel('x');
ylabel('\phi');
title('1D Kink Graph');

grid on;
legend({'Kink', 'Antikink', '\phi=\pm1'}, ...
       'Interpreter', 'latex', 'Location', 'Best');

set(gca, 'TitleFontSizeMultiplier', 2)

set(gcf, 'Color', 'w');
exportgraphics(gcf, 'Kink1D.png', 'Resolution', 300);

% Define potential energy density and gradient part of energy density
U = 1/2 * (1 - phi.^2).^2;
E = 1/2 * gradient(phi, x(2)-x(1));

% Plot energy density of the kink
figure; hold on;

plot(x,  E, 'b', 'LineWidth', 2);

xlabel('x');
ylabel('E');
title('Energy density of a 1D Kink');

grid on;
legend({'Kink', 'Antikink', '\phi=\pm1'}, ...
       'Interpreter', 'latex', 'Location', 'Best');

set(gca, 'TitleFontSizeMultiplier', 2)

set(gcf, 'Color', 'w');
exportgraphics(gcf, 'EnergyDensity1D.png', 'Resolution', 300);