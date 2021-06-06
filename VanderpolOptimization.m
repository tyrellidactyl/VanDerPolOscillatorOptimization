%% Initialize Problem
global T
global K
global w
T = 50;
tspan = 0:.1:T;
z0 = [2,0];

Krange = 25;
wrange = 25;
K = -Krange + (Krange+Krange)*rand(1,1);
w = -wrange + (wrange+wrange)*rand(1,1);

[times, Z] = ode45(@myodefun, tspan, z0);

%% Plots
f1 = figure(1);
clf;
subplot(1,2,1);
grid on
hold on
plot(times, Z(:,1), '-')
plot(times, Z(:,2), '-')
xlabel('t')
ylabel('X')
str = sprintf('U(t) = %0.2f sin(%0.2f * t)',K,w);
title(str)
legend('Velocity (Xdot)','Acceleration (Xdotdot)')

subplot(1,2,2);
grid on
hold on
plot(Z(:,1), Z(:,2), '-')
xlabel('X1')
ylabel('X2')
str = sprintf('Phase Portrait Plot: U(t) = %0.2f sin(%0.2f * t)',K,w);
title(str)

%% Control Functions
function ut = controlfun(t)
global K
global w
ut = K(1) * sin(w(1)*t);
end

function dzdt = myodefun(t,z)
u = controlfun(t);   
dx1dt = z(2);
dx2dt = -z(1) + u;
dzdt = [dx1dt; dx2dt];
end

