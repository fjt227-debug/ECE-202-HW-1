clear all;
close all;
%part A
xcoords = [0 0]; %x-coordinates of charge Q1 and Q2 in m
ycoords = [0 0.01]; %y-coordinates of charge Q1 amd Q2 in m

figure; %new figure
plot(xcoords, ycoords, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
xlabel('x[m]');
ylabel('y[m]');
title('Two Point Charges:Part A');
xlim([-0.02 0.02]);
ylim([-0.02 0.02]);
axis equal; grid on;

%part B

figure; %new figure
xcoords = [0 0]; %x-coordinates of charge Q1 and Q2 in m
ycoords = [0 0.01]; %y-coordinates of charge Q1 amd Q2 in m

plot(xcoords, ycoords, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
xlabel('x[m]');
ylabel('y[m]');
title('Two Point Charges and Electric Forces:Part B');
xlim([-0.02 0.02]);
ylim([-0.02 0.02]);
axis equal; grid on;

Q1 = 1e-9; % Q1 = 1 nC
Q2 = -1e-9; % Q2 = -1 nC
EPS0 = 8.8542 * 10^(-12);

%Calculate force on charge 2 by charge 1
r12 = [xcoords(2)-xcoords(1) ycoords(2) - ycoords(1)];
r12abs = sqrt(r12(1)^2 + r12(2)^2);
r12unit = r12/r12abs;
F12 = (1/(4*pi*EPS0))*(Q1*Q2/(r12abs^2)*r12unit);

%Calculate force on charge 1 by charge 2
r21 = [xcoords(1)-xcoords(2) ycoords(1) - ycoords(2)];
r21abs = sqrt(r21(1)^2 + r21(2)^2);
r21unit = r21/r21abs;
F21 = (1/(4*pi*EPS0))*(Q1*Q2/(r21abs^2)*r21unit);

hold on;

Fx = [F21(1) F12(1)];
Fy = [F21(2) F12(2)];
quiver(xcoords, ycoords, Fx, Fy, 0.5, 'r');
hold off;

disp(['Q2 due to Q1:  Fx = ' num2str(F12(1),'%.6e') ' N,  Fy = ' num2str(F12(2),'%.6e') ' N']);
disp(['Q1 due to Q2:  Fx = ' num2str(F21(1),'%.6e') ' N,  Fy = ' num2str(F21(2),'%.6e') ' N']);

%part C

figure;
xcoords = [0 0]; %x-coordinates of charge Q1 and Q2 in m
ycoords = [0 0.01]; %y-coordinates of charge Q1 amd Q2 in m
v = -.039:.002:.04;  % define x-y grid of points for E-field calculation
[x,y] = meshgrid (v);

plot(x, y, 'k.', 'MarkerSize', 6);
plot(xcoords(1), ycoords(1), 'bo', 'MarkerSize', 6, 'MarkerFaceColor','b'); hold on;
plot(xcoords(2), ycoords(2), 'ro', 'MarkerSize', 6, 'MarkerFaceColor','r');
xlabel('x[m]');
ylabel('y[m]');
title('Meshgrid Due To Two Charges: Part C');
axis equal; grid on;
xlim([-0.04 0.04]); ylim([-0.04 0.04]);
hold off;

%part D

figure;
Q1 = 1e-9; % Q1 = 1 nC
Q2 = -1e-9; % Q2 = -1 nC
EPS0 = 8.8542 * 10^(-12);
xcoords = [0 0]; %x-coordinates of charge Q1 and Q2 in m
ycoords = [0 0.01]; %y-coordinates of charge Q1 amd Q2 in m
v = -.039:.002:.04;  % define x-y grid of points for E-field calculation
[x,y] = meshgrid (v);

plot(x, y, 'k.', 'MarkerSize', 6); hold on;   % grid
plot(xcoords(1), ycoords(1), 'bo', 'MarkerSize', 6, 'MarkerFaceColor','b');
plot(xcoords(2), ycoords(2), 'ro', 'MarkerSize', 6, 'MarkerFaceColor','r');
xlabel('x[m]'); ylabel('y[m]');
title('First Grid: Part D');
axis equal; grid on;
xlim([-0.04 0.04]); ylim([-0.04 0.04]);
hold off;

[M,N] = size(x);
for i = 1:M %go through all y grid points
    for j = 1:N %go through all x grid points
         % Vector from Q1 to grid point
        r1 = [x(i,j)-xcoords(1), y(i,j)-ycoords(1)];
        r1abs = sqrt(r1(1)^2 + r1(2)^2);
        r1hat = r1 ./ r1abs;
        E1 = Q1/(4*pi*EPS0) * r1hat / r1abs^2;

        % Vector from Q2 to grid point
        r2 = [x(i,j)-xcoords(2), y(i,j)-ycoords(2)];
        r2abs = sqrt(r2(1)^2 + r2(2)^2);
        r2hat = r2 ./ r2abs;
        E2 = Q2/(4*pi*EPS0) * r2hat / r2abs^2;

        % Superposition: total E = E1 + E2
        E = E1 + E2;
        Ex(i,j) = E(1);
        Ey(i,j) = E(2);
    end
end

figure;
plot(xcoords(1), ycoords(1), 'bo', 'MarkerSize', 6, 'MarkerFaceColor','b'); hold on;
plot(xcoords(2), ycoords(2), 'ro', 'MarkerSize', 6, 'MarkerFaceColor','r');
xlabel('x[m]');
ylabel('y[m]');
quiver(x,y,Ex,Ey,10,'m');
title('Electric Field Due To Two Charges: Part D');
axis equal; grid on;
hold off;