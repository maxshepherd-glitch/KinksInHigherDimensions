% Set default figure appearance so that dark mode doesn't affect figures
set(0, 'DefaultFigureColor', 'w', ...
       'DefaultAxesColor', 'w', ...
       'DefaultAxesXColor', 'k', ...
       'DefaultAxesYColor', 'k', ...
       'DefaultAxesZColor', 'k', ...
       'DefaultTextColor', 'k', ...
       'DefaultAxesTitleFontWeight', 'normal');

% Define parameters
v  = 0.3;                       
gamma = 1/sqrt(1 - v^2);        
x0 = 0;                         

% Define the size of spatial domain and number of gridpoints in each direction
Lx = 12;  
Ly = 6;  
Nx = 600;
Ny = 220;

% Create spatial grids
x = linspace(-Lx, Lx, Nx);
y = linspace(-Ly, Ly, Ny);

% Generate a 3D meshgrid
[X, Y] = meshgrid(x, y);

% Time discretisation
Tmax = 18;
Nt   = 500;
t    = linspace(0, Tmax, Nt);
t_snap = linspace(0, 16, 6);

% Define moving wall profile
phi_wall = @(X,Y,t) tanh((gamma*(X - v*t - x0)));

PhiXT = zeros(Nt, Nx);

% Evaluate phi(x,t) for each time step
for k = 1:Nt
    PhiXT(k,:) = tanh((gamma*(x - v*t(k) - x0)));
end

% Space-time plot of moving kink
figure;
imagesc(t, x, PhiXT);
set(gca,'YDir','normal','FontSize',12)
xlabel('$t$', 'Interpreter','latex')
ylabel('$x$', 'Interpreter','latex')
title(sprintf('Space--time plot of moving kink (v=%.1f)', v), ...
      'Interpreter','latex', 'FontSize', 24)

cb = colorbar;
cb.Label.String = '$\phi(x,t)$';
cb.Label.Interpreter = 'latex';

colormap(parula)
axis tight

exportgraphics(gcf, 'SpacetimePhi_v03.png', ...
    'Resolution', 300, 'BackgroundColor', 'white');

% Surface plots of moving wall at different times
figure('Color','w');
hold on

for j = 1:numel(t_snap)
    tj = t_snap(j);
    Phi = phi_wall(X, Y, tj);

    h = surf(X, Y, Phi, 'EdgeColor','none');  
    h.FaceAlpha = 0.3;                       
end

view(45, 30)
axis padded
zlim([-1.1 1.1])
set(gca, 'FontSize', 12)

xlabel('$x$', 'Interpreter','latex')
ylabel('$y$', 'Interpreter','latex')
zlabel('$\phi(x,y,t)$', 'Interpreter','latex')

title(sprintf('2D moving domain wall overlaid at multiple times (v=%.1f)', v), ...
      'Interpreter','latex', 'FontSize', 24)

grid on
hold off

exportgraphics(gcf, 'MovingWall2D_v03.png', ...
    'Resolution', 300, 'BackgroundColor', 'white');