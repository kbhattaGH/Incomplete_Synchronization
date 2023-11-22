
function Ldot = Imp_Synch(t, ICn, flag, A, N, beta, a)
%coupling in y
%a?

x = ICn(1:N);
y = ICn(N+1:2*N);
z = ICn(2*N+1:3*N);   
sigma = zeros(N);
for i = 1:N
    for j = (i+1):N
        sigma(i,j) = (y(j)-y(i))^2;
    end
end



Aeff=A.*(sigma+sigma');
Leff=Aeff-diag(sum(Aeff));

%ROESLLER
% xdot = -y-z;
% ydot = x+0.2.*y+beta*Leff*y; % coupling in y;
% zdot = 0.2 +(x-7).*z;

%LORENZ
xdot=10*(y-x);
ydot=-x.*z+26.5*x-y+beta*Leff*y; % coupling in y;
zdot=x.*y-8/3*z;

%HR
%xdot=y+(3*x.^2-x.^3)+3.2-z; %3.2
%ydot=-y+(1-5*x.^2)     +beta*Leff*y;
%zdot=(-6*10^-3*z+24*10^-3*(x+1.6));

Ldot = [xdot;ydot;zdot];
end

%Imp_Synch([0:0.01:100], rand(3*10,1), flag, rand(10), 10, 1, 1)

