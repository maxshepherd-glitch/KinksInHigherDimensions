% Set default figure appearance so that dark mode doesn't affect figures
set(0, 'DefaultFigureColor', 'w', ...
       'DefaultAxesColor', 'w', ...
       'DefaultAxesXColor', 'k', ...
       'DefaultAxesYColor', 'k', ...
       'DefaultAxesZColor', 'k', ...
       'DefaultTextColor', 'k', ...
       'DefaultAxesTitleFontWeight', 'normal');

% Domain size and grid resolution
L = 10;
N = 400;

% Create a spatial grid
x = linspace(-L,L,N);
y = linspace(-L,L,N);
dx = x(2) - x(1);
dy = y(2) - y(1);

[X, Y] = meshgrid(x, y);

% Convert to polar coordinates
r = sqrt(x.^2+y.^2);
theta = atan2(Y, X);

% Skyrmion profile function
r0 = 2;             
f  = pi * exp(-r/r0);

% Define the spin texture s = (sx, sy, sz)
sx = sin(f) .* cos(theta);
sy = sin(f) .* sin(theta);
sz = cos(f);

% Normalise so |s| = 1 everywhere
norm = sqrt(sx.^2 + sy.^2 + sz.^2);

sx = sx ./ norm;
sy = sy ./ norm;
sz = sz ./ norm;

% Compute spatial derivatives of s using finite differences
[sx_x, sx_y] = gradient(sx, dx, dy);
[sy_x, sy_y] = gradient(sy, dx, dy);
[sz_x, sz_y] = gradient(sz, dx, dy);

% Compute cross product
cx = sy_x*sz_y - sz_x*sy_y;
cy = sz_x*sx_y - sx_x*sz_y;
cz = sx_x*sy_y - sy_x*sx_y;

% Compute the topological charge density
q = (1/(4*pi)) *  (sx.*cx + sy.*cy + sz.*cz);

% Numerically integrate q over the plane to get the total charge Q
Q = sum(q, 'all') * dx * dy;

% 2D colour plot of topological charge density
figure;
imagesc(x,y,q)
set(gca,'YDir','normal','FontSize',12)
axis equal tight

xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
title(sprintf('Topological charge density $q(x,y)$  ( $Q\\approx %.3f$ )',Q),...
      'Interpreter','latex','FontSize',24)

cb = colorbar;
cb.Label.String = '$q(x,y)$';
cb.Label.Interpreter = 'latex';
colormap(parula)

exportgraphics(gcf,'Skyrmion_q2D.png',...
    'Resolution',300,'BackgroundColor','white');

% 3D surface plot of topological charge density
figure;
surf(X,Y,q,q,'EdgeColor','none');
view(45,30)
axis padded
set(gca,'FontSize',12)

xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('$q(x,y)$','Interpreter','latex')

title(sprintf('Surface plot of $q(x,y)$  ( $Q\\approx %.3f$ )',Q),...
      'Interpreter','latex','FontSize',24)

cb = colorbar;
cb.Label.String = '$q$';
cb.Label.Interpreter = 'latex';
cb.Position = [0.92 0.25 0.02 0.5];

lighting phong
camlight headlight
colormap(parula)

exportgraphics(gcf,'Skyrmion_q3D.png',...
    'Resolution',300,'BackgroundColor','white');
