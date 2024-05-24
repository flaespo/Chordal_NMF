%MonteCarlo runs for test_h

clear;close all;clc;


r  = 4; % rank
m  = 100; % number of rows 100
n  = 100; % number of columns  100
itermax = 1e3;

MC = 100;
F_EPG_run = zeros(itermax+1,MC); 
F_RMU_run = zeros(itermax+1,MC); 
F_RADMM_run = zeros(itermax+1,MC); 
F_RALM_run = zeros(itermax+1,MC); 

for run = 1:MC

    run
Mo = genData(r,m,n);
M  = normalize(Mo);
[Wini, Hini] = iniWH(M,r,n); % initialization of W,H by random
Fini         = squared_chord_matrices(M,Wini*Hini); % initial object value
F0(1) = Fini;
F1(1) = Fini;
F2(1) = Fini;
F3(1) = Fini;

%%
W       = Wini;
WtW     = W'*W;
WtM     = W'*M;
%update a particular column j of h
j=1;

% EPG
H = Hini;
tic
  for k = 2 : itermax+1
     H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t0(k)  = toc;
     F0(k)  = squared_chord_matrices(M,W*H);
  end
violate_EPG = min(H(:,j));
   

% RMU 
H = Hini;
tic
  for k = 2 : itermax+1
     H(:,j) = h_RMU(WtW,WtM(:,j),H(:,j));  
     t1(k)  = toc;
     F1(k)  = squared_chord_matrices(M,W*H);
 end
violate_RMU = min(H(:,j));

% RADMM
H = Hini;
tic
  for k = 2 : itermax+1
     H(:,j) = h_RADMM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t2(k)  = toc;
     F2(k)  = squared_chord_matrices(M,W*H);
  end
  violate_RADMM = min(H(:,j));

% RALM
H = Hini;
tic
  for k = 2 : itermax+1
     H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t3(k)  = toc;
     F3(k)  = squared_chord_matrices(M,W*H);
  end
 violate_RALM = min(H(:,j));

 % F0 = [Fini F0];
 % F1 = [Fini F1];
 % F2 = [Fini F2];
 % F3 = [Fini F3];
 % t0 = [0 t0];
 % t1 = [0 t1];
 % t2 = [0 t2];
 % t3 = [0 t3];

Fmin = min([min(F0) min(F1) min(F2) min(F3)]);

F_EPG_run(:,run)= F0-Fmin;
F_EPG = F_EPG_run(end,:);

F_RMU_run(:,run)= F1-Fmin;
F_RMU = F_RMU_run(end,:);

F_RADMM_run(:,run)= F2-Fmin;
F_RADMM = F_RADMM_run(end,:);

F_RALM_run(:,run)= F3-Fmin;
F_RALM = F_RALM_run(end,:);

end

F_EPG_median = median(F_EPG_run,2);
F_RMU_median = median(F_RMU_run,2);
F_RADMM_median = median(F_RADMM_run,2);
F_RALM_median = median(F_RALM_run,2);

F_EPG_median_last = F_EPG(end,:);
F_RMU_median_last = F_RMU(end,:);
F_RADMM_median_last = F_RADMM(end,:);
F_RALM_median_last = F_RALM(end,:);

%table ranking
Ranking = [F_EPG_median_last; F_RMU_median_last; F_RADMM_median_last; F_RALM_median_last];
for j=1:MC
    minR_col = min(Ranking(:,j));
    for i=1:4
        if Ranking(i,j)==minR_col
            Ranking(i,j) = 1;
        else
            Ranking(i,j) = 2;
        end
    end
end

figure()
imagesc(Ranking)
labelNames = {'EPG','RMU','RADMM','RALM'};
set(gca,'YTick',1:4);
set(gca,'YTickLabel',labelNames);

rank_EPG = sum(Ranking(1,:)==1)
rank_RMU = sum(Ranking(2,:)==1)
rank_RADMM = sum(Ranking(3,:)==1)
rank_RALM = sum(Ranking(4,:)==1)




figure
    semilogy(t0, F_EPG_median,'k','LineWidth',4),hold on,
    semilogy(t1, F_RMU_median,'b:','LineWidth',2.5),
    semilogy(t2, F_RADMM_median,'r--','LineWidth',2.5),
    semilogy(t3, F_RALM_median,'m:','LineWidth',2.5)
    set(gca,'fontsize', 14)
    grid on
    lgd = legend('EPG','RMU','RADMM','RALM');
    lgd.FontSize = 14;
    axis tight
    msg = strcat('$(m,n,r)=($',num2str(m),',',num2str(n),',',num2str(r),')');
title(msg,'Interpreter','latex','FontSize',14)
xlabel('Time','Interpreter','latex','FontSize',14)
ylabel('$f(h_k)-f_{\textrm{min}}$','Interpreter','latex','FontSize',14)

