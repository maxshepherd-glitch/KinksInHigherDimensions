% Set default figure appearance so that dark mode doesn't affect figures
set(0, 'DefaultFigureColor', 'w', ...
       'DefaultAxesColor', 'w', ...
       'DefaultAxesXColor', 'k', ...
       'DefaultAxesYColor', 'k', ...
       'DefaultAxesZColor', 'k', ...
       'DefaultTextColor', 'k', ...
       'DefaultAxesTitleFontWeight', 'normal');

% Radius range
R = linspace(0,5,400);

% E per unit A_{n-1}
sigma = 1;   

% Dimensions to compare
n_list = [1,2,3,4];

% Plot E against R for each dimension in n_list
figure; hold on
for n = n_list
    E = sigma * R.^(n-1);
    plot(R, E, 'LineWidth', 2);
end

grid on
xlabel('$R$','Interpreter','latex','FontSize',12)
ylabel('$E(R)$','Interpreter','latex','FontSize',12)
title('Scaling energy with spatial dimension', ...
      'Interpreter','latex','FontSize',24)

lgd = legend({'$n=1$','$n=2$','$n=3$','$n=4$'}, ...
       'Interpreter','latex','Location','northwest');
lgd.Color = 'white';
lgd.TextColor = 'black';    
lgd.EdgeColor = 'black';

exportgraphics(gcf,'Energy_nDimensions.png', ...
    'Resolution',300,'BackgroundColor','white');