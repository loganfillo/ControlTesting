function [xdot] = auvmodel(x, tau)
%
% [xdot] = auvmodel(x, tau) returns the time derivative of the 
% state vector for the UBC Subbots Autonomous Underwater Vehicle 
% (AUV) given an input state (x = [u v w p q r x y z phi theta psi])
% and a desired external force input (tau = [Xe Ye Ze Ke Me Ne])

if (length(x) ~= 12),error('x-vector must have dimension 12 !');end

u = x(1); % surge velocity          (m/s)
v = x(2); % sway velocity           (m/s)
w = x(3); % heave velocity          (m/s)
p = x(4); % roll velocity           (rad/s)
q = x(5); % pitch velocity          (rad/s)
r = x(6); % yaw velocity            (rad/s)
x = x(7); % position in x-direction (m)
y = x(8); % position in y-direction (m)
z = x(9); % position in z-direction (m)
phi = x(10); % roll angle           (rad)
theta =  x(11); % pitch angle       (rad)
psi = x(12); % yaw angle            (rad)

if (length(tau) ~= 6),error('tau-vector must have dimension 6 !');end

Xe = tau(1); % external force in x-direction   (N)
Ye = tau(2); % external force in y-direction   (N)
Ze = tau(3); % external force in z-direction   (N)
Ke = tau(4); % external torque in x-direction  (N)
Me = tau(5); % external torque in y-direction  (N)
Ne = tau(6); % external torque in z-direction  (N)

const.rho_water = 1014.0; % water density (Kg/m^2)
const.g = 9.81;           % gravitational constant (m/s^2)

m = 100;     % mass of auv           (Kg)
Ixx = 10;    % inertia around x-axis (Kg*m^2)
Iyy = 10;    % inertia around y-axis (Kg*m^2)
Izz = 10;    % inertia around z-axis (Kg*m^2)


M = [ m, 0, 0, 0, 0, 0; ...
      0, m, 0, 0, 0, 0; ...
      0, 0, m, 0, 0, 0; ...
      0, 0, 0, Ixx, 0, 0; ...
      0, 0, 0, 0, Iyy, 0; ...
      0, 0, 0, 0, 0, Izz ]; % mass and inertia matrix