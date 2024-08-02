function [Mo,nrow,ncol,m,n, M, n_col_M, X, nband] = loadBrowser_nocloud
%load('X.mat');
%new data
load('X_nocloud.mat');

[nrow, ncol, nband] = size(X);

figure,
for i = 1 : nband
subplot(3,4,i)
imshow(X(:,:,i)),pbaspect([1 nrow/ncol 1])
title(i)
end

for i = 1 : nband
   slice = X(:,:,i); 
 Mo(i,:) = double(slice(:));
end
%% Size
[m,n] = size(Mo);

%% Normalize
[M, n_col_M] = normalize(Mo);

figure,
imagesc(reshape(n_col_M,nrow, ncol)),
colorbar,
pbaspect([1 nrow/ncol 1]),
title('energy of M')
end%EOF