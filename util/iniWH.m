function [W,H] = iniWH(M,r,n) % initialize W and H
%% Initialization using random
W = rand(size(M,1),r);
H = rand(r,n);

%% Initialization using SPA
%{
% Using SPA to initialize W
options.normalize = 1;
K = SPA(M,r,options);
W = M(:,K);
% H via nonnegative least squares using HALS
options.algo = 'HALS';
H = NNLS(W,M,options); 
%}
%% Making sure <WtW h, h > == 1
WtW = W'*W;
for j = 1 : n
 u = WtW\H(:,j);
 u = u / norm(u);
 H(:,j) = WtW*u;
end

end%EOF
