function [Mnoisy, Wexact, Hexact, Mexact, additiveNoise] = genData(r,m,n)
%% Synthetic 
Wexact = max(0,randn(m,r));
Hexact = max(0,rand(r,n));  
additiveNoise  = rand(m,n);
Mexact = Wexact*Hexact; %(exact data)
Mnoisy = Mexact+additiveNoise;
%% Microarray dataset
% MM = load('MM.mat'); 
% M_raw = MM.MM(1:15464, 2:11);
% M =table2array(M_raw); 
% r = 8;
% [n,m] = size(M);

%% Moffet hyperspectral dataset
% Moffet = load('Moffet.mat'); 
% M = (Moffet.X)'; 
% r = 3;
% [n,m] = size(M);
end%EOF