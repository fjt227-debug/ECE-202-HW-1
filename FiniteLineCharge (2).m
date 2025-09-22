clear all;
close all;

EPS0 = 8.8542 * 10^(-12);
a = 0.01; % a = 1 cm
Q = 1e-9; % Q = 1 nC
rho = Q/a ; % line charge density Q' = rho = Q/a
Nseg = 100; % Number of segments
dl = a/Nseg; % Length of each segment
yline = -a/2+dl/2 : dl : a/2; % y-coordinates of segment centers
xline = zeros (1,length (yline)); % x-coordinates of segment centers

v = -0.825*a: 0.15*a : 0.825*a; 
u = -0.525*a: 0.15*a : 0.525*a;
[x,y] = meshgrid(v,u);

figure;
plot(x,y,'k*','MarkerSize',3); % plot our grid
hold on;
xlabel('x[m]');
ylabel('y[m]');
line([0 0],[-a/2 a/2]); %vertical line
xp = 0.005;
yp = 0.005;
plot(xp, yp, 'ro', 'MarkerFaceColor','r');
Ex = 0; Ey = 0;
for t = 1:length(xline)
    rx = xp - xline(t);
    ry = yp - yline(t);
    r  = sqrt(rx^2 + ry^2);
    ux = rx / r;                      
    uy = ry / r;
    dE = (rho * dl) / (4*pi*EPS0 * r^2);
    Ex = Ex + dE * ux;
    Ey = Ey + dE * uy;
end

quiver(xp, yp, Ex, Ey, 0.002, 'b', 'LineWidth', 1.2);
axis equal; 
grid on;
title(sprintf('Electric Field at Point 0.005m,0.005m', xp, yp, Nseg));
xlim([-0.01 0.01]); ylim([-0.005 0.01]);
hold off;