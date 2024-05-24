function W = W_FastEPG(M,W,H,m,n,r)
% Euclidean Projected Gradient on W with Nesterov's acceleration

Y = W;
for k = 1 : 5
     W_ = W;  
     W = W_EPG(M,Y,H,m,n,r);
     Y = W + (k-1)/(k+2)*(W-W_);
end
end%EOF
