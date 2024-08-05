% MonteCarlo runs for test_W
clear;close all;clc;

%% Get data & inizialization
r  = 4; % rank
m  = 50; % number of rows 100
n  = 100; % number of columns  100
itermax = 1e3;

MC = 100;
F_EPG_run = zeros(itermax+1,MC); 
F_consesusRMU_run = zeros(itermax+1,MC); 
F_FracProg_run = zeros(itermax+1,MC); 


for run = 1:MC
    
    run

Mo = genData(r,m,n);
M  = normalize(Mo);
[Wini, Hini] = iniWH(M,r,n); % initialization of W,H by random
Fini         = squared_chord_matrices(M,Wini*Hini); % initial object value
F0(1) = Fini;
F1(1) = Fini;
F2(1) = Fini;
%%
H       = Hini;
%update a particular column j of h

% EPG
W = Wini;
tic
  for k = 2 : itermax+1
     W      = W_EPG(M,W,H,m,n,r);
     t0(k)  = toc;
     F0(k)  = squared_chord_matrices(M,W*H);
  end
violate_EPG = min(W(:));

%consensus RMU 
W = Wini;
tic
  for k = 2 : itermax+1
     W      = W_consensusRMU(M,W,H,m,n,r);
     t1(k)  = toc;
     F1(k)  = squared_chord_matrices(M,W*H);
 end
violate_RMU = min(W(:));

% FracProj
W = Wini;
tic
  for k = 2 : itermax+1
          W = W_FracProg(M,W,H,n);
     t2(k)  = toc;
     F2(k)  = squared_chord_matrices(M,W*H);
  end
  violate_FracProj = min(W(:));

%%
% F0 = [Fini F0];
% F1 = [Fini F1];
% F2 = [Fini F2];
% t0 = [0 t0];
% t1 = [0 t1];
% t2 = [0 t2];

Fmin = min([min(F0) min(F1) min(F2)]);

F_EPG_run(:,run)= F0-Fmin;
F_EPG = F_EPG_run(end,:);

F_consesusRMU_run(:,run)= F1-Fmin;
F_consensusRMU = F_consesusRMU_run(end,:);

F_FracProg_run(:,run)= F2-Fmin;
F_FracProg = F_FracProg_run(end,:);

end

F_EPG_median = median(F_EPG_run,2);
F_consensusRMU_median = median(F_consesusRMU_run,2);
F_FracProg_median = median(F_FracProg_run,2);

F_EPG_median_last = F_EPG(end,:);
F_consesusRMU_median_last = F_consensusRMU(end,:);
F_FracProg_median_last = F_FracProg(end,:);


%table ranking
Ranking = [F_EPG_median_last; F_consesusRMU_median_last; F_FracProg_median_last];
for j=1:MC
    minR_col = min(Ranking(:,j));
    for i=1:3
        if Ranking(i,j)==minR_col
            Ranking(i,j) = 1;
        else
            Ranking(i,j) = 2;
        end
    end
end

figure()
imagesc(Ranking)
labelNames = {'EPG','consensusRMU','FracProg'};
set(gca,'YTick',1:3);
set(gca,'YTickLabel',labelNames);

rank_EPG = sum(Ranking(1,:)==1)
rank_consesusRMU = sum(Ranking(2,:)==1)
rank_FracProg = sum(Ranking(3,:)==1)


figure
    semilogy(t0, F_EPG_median,'k','LineWidth',4),hold on,
    semilogy(t1, F_consensusRMU_median,'b:','LineWidth',2.5),
    semilogy(t2, F_FracProg_median,'r--','LineWidth',2.5),
    set(gca,'fontsize', 14)
    grid on
    lgd = legend('EPG','consensusRMU','FracProg');
    lgd.FontSize = 14;
    axis tight
    msg = strcat('$(m,n,r)=($',num2str(m),',',num2str(n),',',num2str(r),')');
title(msg,'Interpreter','latex','FontSize',14)
xlabel('Time','Interpreter','latex','FontSize',14)
ylabel('$f(h_k)-f_{\textrm{min}}$','Interpreter','latex','FontSize',14)

% [violate_EPG violate_RMU violate_FracProj violate_Greedy]
