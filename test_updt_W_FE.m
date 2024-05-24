% test convergence of W
clear;close all;clc;
%% Get data & inizialization
r  = 4; % rank
m  = 50; % number of rows
n  = 100; % number of columns
Mo = genData(r,m,n);
M  = normalize(Mo);
[Wini, Hini] = iniWH(M,r,n); % initialization of W,H by random
Fini         = squared_chord_matrices(M,Wini*Hini); % initial object value
%%
itermax = 1e3;
H       = Hini;
%update a particular column j of h

% EPG
W = Wini;
tic
  for k = 1 : itermax
     W      = W_EPG(M,W,H,m,n,r);
     t0(k)  = toc;
     F0(k)  = squared_chord_matrices(M,W*H);
  end
violate_EPG = min(W(:));

% RMU 
W = Wini;
tic
  for k = 1 : itermax
     W      = W_consensusRMU(M,W,H,m,n,r);
     t1(k)  = toc;
     F1(k)  = squared_chord_matrices(M,W*H);
 end
violate_RMU = min(W(:));

% FracProj
W = Wini;
tic
  for k = 1 : itermax
          W = W_FracProg(M,W,H,n);
     t2(k)  = toc;
     F2(k)  = squared_chord_matrices(M,W*H);
  end
  violate_FracProj = min(W(:));

% Greedy
W = Wini;
tic
for k = 1 : itermax
    % W = W_greedyRMU2(M,W,H,n);
    t3(k)  = toc;
    F3(k)  = squared_chord_matrices(M,W*H);
end
violate_Greedy = min(W(:));
%%
F0 = [Fini F0];
F1 = [Fini F1];
F2 = [Fini F2];
F3 = [Fini F3];
t0 = [0 t0];
t1 = [0 t1];
t2 = [0 t2];
t3 = [0 t3];

Fmin = min([min(F0) min(F1) min(F2) min(F3)]);
figure
    semilogy(t0, F0-Fmin,'k','LineWidth',4),hold on,
    semilogy(t1, F1-Fmin,'b:','LineWidth',2.5),
    semilogy(t2, F2-Fmin,'r--','LineWidth',2.5),
    semilogy(t3, F3-Fmin,'m:','LineWidth',2.5)
    set(gca,'fontsize', 14)
    grid on
    lgd = legend('EPG','consensusRMU','FracProg','GreedyRMU');
    lgd.FontSize = 14;
    axis tight
    msg = strcat('$(m,n,r)=($',num2str(m),',',num2str(n),',',num2str(r),')');
title(msg,'Interpreter','latex','FontSize',14)
xlabel('Time','Interpreter','latex','FontSize',14)
ylabel('$f(h_k)-f_{\textrm{min}}$','Interpreter','latex','FontSize',14)

 [violate_EPG violate_RMU violate_FracProj violate_Greedy]