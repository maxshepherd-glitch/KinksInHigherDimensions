set(0, 'DefaultFigureColor', 'w', ...        % Figure background
       'DefaultAxesColor', 'w', ...          % Axes background
       'DefaultAxesXColor', 'k', ...         % X-axis color (black)
       'DefaultAxesYColor', 'k', ...         % Y-axis color
       'DefaultAxesZColor', 'k', ...         % Z-axis color (3D)
       'DefaultTextColor', 'k', ...          % Text color (titles, labels)
       'DefaultAxesTitleFontWeight', 'normal', ...
       'DefaultLegendTextColor', 'k', ...    % Legend text color (R2021a+)
       'DefaultLegendColor', 'w');           % Legend background

Lx = 10;      
Ly = 6;       
Nx = 500;     
Ny = 300;     

x = linspace(-Lx, Lx, Nx);
y = linspace(-Ly, Ly, Ny);
[X, Y] = meshgrid(x, y);

phi = tanh(X / sqrt(2));

figure;
surf(X, Y, phi, phi, 'EdgeColor', 'none');
view(45, 30)
axis tight

xlabel('x');
ylabel('y');
zlabel('\phi(x,y)');

title('2D domain wall: $\phi(x,y)=\tanh(x/\sqrt{2})$', 'Interpreter', 'latex');

cb = colorbar;
cb.Label.String = '\phi';
cb.Position(4) = 0.6;
cb.Position(2) = 0.2;
cb.Position(1) = 0.93;

set(gca, 'TitleFontSizeMultiplier', 2)

exportgraphics(gcf, 'Kink2D.png', ...
    'Resolution', 300, ...
    'BackgroundColor', 'white');