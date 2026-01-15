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

% Define the size of spatial domain and number of gridpoints in each direction
Lx = 10;      
Ly = 6;       
Nx = 500;     
Ny = 300;     

% Create spatial grids and compute grid spacings
x = linspace(-Lx, Lx, Nx);
y = linspace(-Ly, Ly, Ny);
dx = x(2) - x(1);
dy = y(2) - y(1);

% Generate 3D meshgrid
[X, Y] = meshgrid(x, y);

% Define 2D domain wall
phi = tanh(X);

% Surface plot of 2D domain wall
figure;
surf(X, Y, phi, phi, 'EdgeColor', 'none');
view(45, 30)
axis tight

xlabel('x');
ylabel('y');
zlabel('\phi(x,y)');

title('2D domain wall: $\phi(x,y)=\tanh(x/\sqrt{2})$', 'Interpreter', 'latex', 'FontSize', 24);

cb = colorbar;
cb.Label.String = '\phi';
cb.Position(4) = 0.6;
cb.Position(2) = 0.2;
cb.Position(1) = 0.93;

set(gca, 'TitleFontSizeMultiplier', 2)

exportgraphics(gcf, 'Kink2D.png', ...
    'Resolution', 300, ...
    'BackgroundColor', 'white');

% Compute spatial derivatives
[phi_x, phi_y] = gradient(phi, dx, dy);

% Define potential energy density and total energy density
U = 1/2 * (1 - phi.^2).^2;
E = 1/2 * (phi_x.^2 + phi_y.^2) + U;

% Surface plot of energy density
figure; 
surf(X, Y, E, E, 'EdgeColor','none');
view(45,30)
axis padded
set(gca, 'FontSize',12)

xlabel('$x$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
zlabel('$E(x,y)$', 'Interpreter','latex');

title('Energy density of a 2D domain wall', 'FontSize', 24);

cb = colorbar;
cb.Label.String = '$E$';
cb.Label.Interpreter = 'latex';
cb.Position(4) = 0.6;
cb.Position(2) = 0.2;
cb.Position(1) = 0.93;

exportgraphics(gcf, 'EnergyDensity2D.png', ...
    'Resolution', 300, ...
    'BackgroundColor', 'white');