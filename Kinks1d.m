set(0, 'DefaultFigureColor', 'w', ...        % Figure background
       'DefaultAxesColor', 'w', ...          % Axes background
       'DefaultAxesXColor', 'k', ...         % X-axis color (black)
       'DefaultAxesYColor', 'k', ...         % Y-axis color
       'DefaultAxesZColor', 'k', ...         % Z-axis color (3D)
       'DefaultTextColor', 'k', ...          % Text color (titles, labels)
       'DefaultAxesTitleFontWeight', 'normal', ...
       'DefaultLegendTextColor', 'k', ...    % Legend text color (R2021a+)
       'DefaultLegendColor', 'w');           % Legend background

x = linspace(6, -6, 400);
phi = tanh(x / sqrt(2));

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

set(gcf, 'Color', 'w');
exportgraphics(gcf, 'Kink1D.png', 'Resolution', 300);
