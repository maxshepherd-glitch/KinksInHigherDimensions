% Set default figure appearance so that dark mode doesn't affect figures
set(0, 'DefaultFigureColor', 'w', ...
       'DefaultAxesColor', 'w', ...
       'DefaultAxesXColor', 'k', ...
       'DefaultAxesYColor', 'k', ...
       'DefaultAxesZColor', 'k', ...
       'DefaultTextColor', 'k', ...
       'DefaultAxesTitleFontWeight', 'normal');

% Domain size and grid resolution
Lx = 10;
Ly = 6;
Nx = 1200;
Ny = 400;

% Grid spacing
x = linspace(-Lx, Lx, Nx);
y = linspace(-Ly, Ly, Ny);
dx = x(2) - x(1);
dy = y(2) - y(1);

[X, Y] = meshgrid(x, y);

% Define potential
U = @(phi) 0.5*(1-phi.^2).^2;

% Define sech for simplicity
sech = @(z) 1./cosh(z);

% Straight domain wall is 1D kink extension
phi = tanh(X);

% Define derivatives
phiX = sech(X).^2;
phiY = zeros(size(phi));

% Energy density and energy per unit length
e = 0.5*(phiX.^2 + phiY.^2) + U(phi);

% Total energy on finite box
E = sum(e, 'all') * dx * dy;

% Energy per unit length of finite box
sigma = E/(2 * Ly)

% 2D colour plot of energy density
figure;
imagesc(x, y, e);
set(gca,'YDir','normal','FontSize',12)
axis tight
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
title(sprintf('Domain wall energy density E($x,y$)  ( $\\sigma \\approx %.4f$ )', sigma), ...
      'Interpreter','latex','FontSize',24)

cb = colorbar;
cb.Label.String = 'E(x,y)';
cb.Label.Interpreter = 'latex';
colormap(parula)

exportgraphics(gcf,'DomainWall_EnergyDensity_2D.png', ...
    'Resolution',300,'BackgroundColor','white');

% 3D surface plot of energy density
figure;
surf(X, Y, e, e, 'EdgeColor','none');
view(45,30)
axis tight
set(gca,'FontSize',12)

xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('E','Interpreter','latex')

title(sprintf('Surface plot of E($x,y$)  ( $\\sigma \\approx %.4f$ )', sigma), ...
      'Interpreter','latex','FontSize',24)

cb = colorbar;
cb.Label.String = 'E';
cb.Label.Interpreter = 'latex';
cb.Position = [0.92 0.25 0.02 0.5];  

lighting phong
camlight headlight
colormap(parula)

exportgraphics(gcf,'DomainWall_EnergyDensity_3D.png', ...
    'Resolution',300,'BackgroundColor','white');
