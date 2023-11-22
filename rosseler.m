function [x,y,z] = rosseler(plot, initV, T, eps)
% rosseler Function generates the rosseler attractor
%
%   [X,Y,Z] = rosseler(RHO,SIGMA,BETA,INITV,T,EPS)
%       X, Y, Z - output vectors of the strange attactor trajectories
%       RHO     - Rayleigh number
%       SIGMA   - Prandtl number
%       BETA    - parameter
%       INITV   - initial point
%       T       - time interval
%       EPS     - ode solver precision
%
% Example.
%        [X Y Z] = rosseler(28, 10, 8/3);
%        plot3(X,Y,Z);

if nargin<1
  error('MATLAB:rosseler:NotEnoughInputs','Not enough input arguments.'); 
end

if nargin<2
  eps = 10e-8;
  T = [0 50];
  %initV = [0 1 1.05];
   initV = [0 1 1.05];
end
options = odeset('RelTol',10e-8,'AbsTol',10e-8);
%options = odeset('RelTol',eps,'AbsTol',[eps eps eps/10]);
[T,X] = ode45(@(T,X) F(T, X), T, initV, options);

if plot == 1
    plot3(X(:,1),X(:,2),X(:,3));
axis equal;
grid;
title('rosseler attractor');
xlabel('X'); ylabel('Y'); zlabel('Z');
end

x = X(:,1);
y = X(:,2);
z = X(:,3);
return
end

function dx = F(T, X)
% Evaluates the right hand side of the rosseler system
%xdot = -y-z; % coupling in x;
%ydot = x+0.2.*y; 
%zdot = 0.2 +(x-7).*z;


    dx = zeros(3,1);
    dx(1) = -X(2) - X(3);
    dx(2) = X(1)+0.2.*X(2);
    dx(3) = 0.2+(X(1)-7).*X(3);
    return
end