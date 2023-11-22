clear all
clc
rng(0) % seed for reproducing results
num_iter = 50; % number of iterations

EE=[];

for kk=1:num_iter
run("ERgraph.m") %uncomment to generate ER graphs
A=full(SW); 
%A = [0,1;1,0]; %uncomment to generate 2x2 graph



N = length(A);

%find nominal initial conditions by running an uncoupled oscillator until
%the dynamics reaches the attractor.
%The IC is validated by plotting the dynamics to ensure it is in the
%attractor (Check fig 1 after running code)

%IC = [-3.17985517685868,-1.60694964504211,0.0194175964345542];%manual
%entry if needed

%[X,Y,Z] = lorenz(26.5, 10, 8/3,1); %uncomment for lorrenz

[X,Y,Z] = rosseler(1); %uncomment for rosseller


IC=[X(end),Y(end),Z(end)];

options = odeset('RelTol',10e-8,'AbsTol',10e-8);
E2=[];

 a = 10^-2;
for jj = 1:1    
  jj
 ICn = kron(IC, ones(N,1));
ICn = ICn + [randn(N, 2).*10^-2, zeros(N,1)];
reshape(ICn.',1,[])
 ii = 1;
    for beta = logspace(-1, 4, 21)
    
        beta
        
    [t,x]=ode45('Imp_Synchx',[0 1000],ICn,options, A, N, beta, a);%1000
    T = round(length(x)*0.8);
    
     %Err=x(1:end,[1:N]) - mean(x(1:end,[1:N]),2);
     
    Errorx = ([x(T:end, [1:N]) - mean(x(T:end, [1:N]),2)]');
    Errory = ([x(T:end, [N+1:2*N]) - mean(x(T:end, [N+1:2*N]),2)]');
    Errorz = ([x(T:end, [2*N+1:3*N]) - mean(x(T:end, [2*N+1:3*N]),2)]');
    %Error=(Errorx+Errory+Errorz)/3;
    %plot(t(27803:end),abs(Err(27803:end,1)))

     
    Er=[];
    for j=1:length(Errorx)
    Er(j)=sqrt(Errorx(j)^2+Errory(j)^2+Errorz(j)^2);
    end
    
    
    S(ii)= beta;
    E(ii)= mean(Er);
    E_st(ii) = std(Er);
    
    %T = 0; 
 
 %for m = 1:length(x)
 %    if x(m, 13) < 2
 %        T = T +1;
 %    else
 %    end
 %end
 Time(ii) = T/length(t);
ii = ii+1;
 
    end
EE(kk,:)= E
EE_st(kk,:) = E_st
  E2=cat(1, E2, E);
end


EAvg = mean(E2);
%plot3(x(:, 1), x(:, 7), x(:, 13))

end

%% If there is more than one iteration, take mean and standard deviation
if kk ~= 1
EE_avg = mean(EE);
graph_st = std(EE);
EE_st_avg = mean(EE_st);
EE_st_st = std(EE_st);


%figure Mean of average error (in num iter graphs) vs sigma
 figure
 errorbar(S,EE_avg,graph_st,"vertical",'-o','Color','k')
 xlabel('\sigma', 'fontsize', 18)
 ylabel('E', 'fontsize', 18)
 set(gca,'XScale','log','YScale','log') 



%figure Mean of SD of error (in num iter graphs) vs sigma
 figure
 plot(S,EE_st_avg,'-o','Color','k')
 %errorbar(S,EE_st_avg,EE_st_st,"vertical",'-o') %uncomment for standard
 %deviation
 xlabel('\sigma', 'fontsize', 18)
 ylabel('\Delta E', 'fontsize', 18)
 set(gca,'XScale','log','YScale','log')


else

%IF number of iteration is 1, dont have to take mean
EE_avg = EE;
EE_st_avg = EE_st;



%Average error vs sigma
 figure
 plot(S,EE_avg,'-o','Color','k')
 xlabel('\sigma', 'fontsize', 18)
 ylabel('E', 'fontsize', 18)
 set(gca,'XScale','log','YScale','log') 


%SD of error vs sigma
 figure
 plot(S,EE_st_avg,'-o','Color','k')
 %errorbar(S,EE_st_avg,EE_st_st,"vertical",'-o')
 xlabel('\sigma', 'fontsize', 18)
 ylabel('\Delta E', 'fontsize', 18)
 set(gca,'XScale','log','YScale','log')

end

% figure
% loglog(S, EE,'-o')
% xlabel('\sigma', 'fontsize', 18)
% ylabel('E', 'fontsize', 18)
         
         