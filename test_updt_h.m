% test convergence of h

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
W       = Wini;
WtW     = W'*W;
WtM     = W'*M;
%update a particular column j of h
j=1;

% EPG
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t0(k)  = toc;
     F0(k)  = squared_chord_matrices(M,W*H);
  end
violate_EPG = min(H(:,j));

% RMU 
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RMU(WtW,WtM(:,j),H(:,j));  
     t1(k)  = toc;
     F1(k)  = squared_chord_matrices(M,W*H);
 end
violate_RMU = min(H(:,j));

% RADMM
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RADMM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t2(k)  = toc;
     F2(k)  = squared_chord_matrices(M,W*H);
  end
  violate_RADMM = min(H(:,j));

% RALM
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t3(k)  = toc;
     F3(k)  = squared_chord_matrices(M,W*H);
  end
 violate_RALM = min(H(:,j));
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
subplot(121)
    semilogy(t0, F0-Fmin,'k','LineWidth',4),hold on,
    semilogy(t1, F1-Fmin,'b:','LineWidth',2.5),
    semilogy(t2, F2-Fmin,'r--','LineWidth',2.5),
    semilogy(t3, F3-Fmin,'m:','LineWidth',2.5)
    set(gca,'fontsize', 14)
    grid on
    lgd = legend('EPG','RMU','RADMM','RALM');
    lgd.FontSize = 14;
    axis tight
    msg = strcat('$(m,n,r)=($',num2str(m),',',num2str(n),',',num2str(r),')');
title(msg,'Interpreter','latex','FontSize',14)
xlabel('Time','Interpreter','latex','FontSize',14)
ylabel('$f(h_k)-f_{\textrm{min}}$','Interpreter','latex','FontSize',14)

 [violate_EPG violate_RMU violate_RADMM violate_RALM]


















clear;
 r  = 4; % rank
m  = 100; % number of rows
n  = 100; % number of columns
Mo = genData(r,m,n);
M  = normalize(Mo);
[Wini, Hini] = iniWH(M,r,n); % initialization of W,H by random
Fini         = squared_chord_matrices(M,Wini*Hini); % initial object value
%%
itermax = 1e3;
W       = Wini;
WtW     = W'*W;
WtM     = W'*M;
%update a particular column j of h
j=2;

% R EPG
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t0(k)  = toc;
     F0(k)  = squared_chord_matrices(M,W*H);
  end
violate_EPG = min(H(:,j));

% RMU 
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RMU(WtW,WtM(:,j),H(:,j));  
     t1(k)  = toc;
     F1(k)  = squared_chord_matrices(M,W*H);
 end
violate_RMU = min(H(:,j));

% RADMM
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RADMM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t2(k)  = toc;
     F2(k)  = squared_chord_matrices(M,W*H);
  end
  violate_RADMM = min(H(:,j));

% RALM
H = Hini;
tic
  for k = 1 : itermax
     H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W, 10);
     t3(k)  = toc;
     F3(k)  = squared_chord_matrices(M,W*H);
  end
 violate_RALM = min(H(:,j));
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
subplot(122)
    semilogy(t0, F0-Fmin,'k','LineWidth',4),hold on,
    semilogy(t1, F1-Fmin,'b:','LineWidth',2.5),
    semilogy(t2, F2-Fmin,'r--','LineWidth',2.5),
    semilogy(t3, F3-Fmin,'m:','LineWidth',2.5)
    set(gca,'fontsize', 14)
    grid on
    lgd = legend('EPG','RMU','RADMM','RALM');
    lgd.FontSize = 14;
    axis tight
    msg = strcat('$(m,n,r)=($',num2str(m),',',num2str(n),',',num2str(r),')');
title(msg,'Interpreter','latex','FontSize',14)
xlabel('Time','Interpreter','latex','FontSize',14)
ylabel('$f(h_k)-f_{\textrm{min}}$','Interpreter','latex','FontSize',14)

 [violate_EPG violate_RMU violate_RADMM violate_RALM]