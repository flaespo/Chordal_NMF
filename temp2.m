clear;close all;clc
[Mo,nrow,ncol,m,n,M,n_col_M,X,nband] = loadBrowser;
r = 3;
[Wini, Hini] = iniWH(Mo,r,n); % initialization of W,H by random
Fini         = squared_chord_matrices(M,Wini*Hini) % initial object value
% Run Methods
[Wo,Ho] = FroNMF(M,r);
%%
[W2,H2,F,T,o] = MU_h_conMU_W(M,Wini,Hini,200,10);
figure,plot(F)
%% 
[Ho,H2] = reNorm(n_col_M,nrow, ncol, Ho,H2);
[Wo,Ho] = swapNorm(Wo,Ho);
[W2,H2] = swapNorm(W2,H2);

% plot H map
myPlotH(nrow, ncol, Ho, H2);
% plot M and WHfro WH2
myPlotMWH(nrow, ncol, 4, Mo, Wo, Ho, W2, H2);

[Fini squared_chord_matrices(M,Wo*Ho) squared_chord_matrices(M,W2*H2)]

% plot poster (color image)
plotRGB(Mo, Wo,Ho,W2,H2, nrow,ncol)

% plot H
figure
subplot(211)
imagesc([reshape(Ho(3,:),nrow, ncol) reshape(Ho(2,:),nrow, ncol) reshape(Ho(1,:),nrow, ncol)])
colorbar
ylabel('H (FroNMF)','FontSize',25)

subplot(212)
imagesc([reshape(H2(1,:),nrow, ncol) reshape(H2(2,:),nrow, ncol) reshape(H2(3,:),nrow, ncol)])
colorbar
ylabel('H (ChordalNMF)','FontSize',25)