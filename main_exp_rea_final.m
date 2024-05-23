clear;close all;clc
[Mo, nrow,ncol,m,n,M,n_col_M,X,nband] = loadBrowser;
[Mo_nocloud, nrow_nocloud,ncol_nocloud,m_nocloud,n_nocloud,M_nocloud,n_col_M_nocloud,X_nocloud,nband_nocloud] = loadBrowser_nocloud;

r            = 3;

Iter         = 1e4;   % max iteration 

[Wini, Hini] = iniWH(Mo,r,n); % inialization

Fini       = squared_chord_matrices(M,Wini*Hini); % initial object value
Fini_nocloud       = squared_chord_matrices(M_nocloud,Wini*Hini); % initial object value

%% Run Methods
%%%%%%%
%Fro
[Wfro,Hfro] = FroNMF(M,r);
[Wfro_nocloud,Hfro_nocloud] = FroNMF(M_nocloud,r);

%%%%%%%
%RE:=RMU_EPG
o.algoH = 'RMU';
o.algoW = 'EPG';
[Wre,Hre,Fre,Tre,ore] = Chordal(M,Wini,Hini,Iter,o); % Chordal-NMF by BCD
[Wre_nocloud,Hre_nocloud,Fre_nocloud,Tre_nocloud,ore_nocloud] = Chordal(M_nocloud,Wini,Hini,Iter,o); % Chordal-NMF by BCD
[Wre_joint,Hre_joint,Fre_joint,Tre_joint,ore_joint] = Chordal(M_joint,Wini,Hini,Iter,o); % Chordal-NMF by BCD

%%%%%%%
%RFP:=RMU_FracProg
o.algoH = 'RMU';
o.algoW = 'FracProg';
[Wrfp,Hrfp,Frfp,Trfp,orfp] = Chordal(M,Wini,Hini,Iter,o); % Chordal-NMF by BCD
[Wrfp_nocloud,Hrfp_nocloud,Frfp_nocloud,Trfp_nocloud,o_nocloud] = Chordal(M_nocloud,Wini,Hini,Iter,o); % Chordal-NMF by BCD



Err = [Fini squared_chord_matrices(M,Wfro*Hfro) squared_chord_matrices(M,Wre*Hre) squared_chord_matrices(M,Wrfp*Hrfp);
 Fini_nocloud squared_chord_matrices(M_nocloud,Wfro_nocloud*Hfro_nocloud) squared_chord_matrices(M_nocloud,Wre_nocloud*Hre_nocloud) squared_chord_matrices(M_nocloud,Wrfp_nocloud*Hrfp_nocloud);
 Fini_joint squared_chord_matrices(M_joint,Wfro_joint*Hfro_joint) squared_chord_matrices(M_joint,Wre_joint*Hre_joint) squared_chord_matrices(M_joint,Wrfp_joint*Hrfp_joint)];
rowNames = {'cloud', 'nocloud','joint'};
colNames = {'Ini','Fro','RE','RFP'};
ErrTable = array2table(Err,'RowNames',rowNames,'VariableNames',colNames)

% plot RGB (color image)
plotRGB(M_nocloud, Wfro,Hfro,Wre,Hre, nrow,ncol)
plotRGB(M, Wfro,Hfro,Wre,Hre, nrow,ncol)

plotRGB(M_nocloud,M, Wfro,Hfro,Wre,Hre, nrow,ncol)

