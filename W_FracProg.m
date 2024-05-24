function W = W_FracProg(M,W,H,n)
% one iteration of Euclidean Fractional Programming (Dinkelbach) on W

% initialize the gradW matrix
gradW = zeros(size(W));

WtW   = W'*W;
% fill in the Lambda matrix
for j = 1 : n
 mj     = M(:,j);
 hj     = H(:,j);
 Aj     = hj*hj';
 Bj     = mj*hj';
 Wh     = W*hj;
 lambda = trace(Bj'*W)/sqrt(Wh'*Wh);
 gradW  = gradW + (lambda/2)*(W*Aj)/sqrt(trace(Aj'*WtW)) - Bj;
end

% initial stepsize for line search
alpha = 1; 
% initial function value for doing the line search
F_pre = squared_chord_matrices(M,W*H);
% Line search
     W_temp = max(0, W - alpha*gradW);
     F_cur  = squared_chord_matrices(M,W_temp*H);
while F_cur > F_pre
      alpha = alpha / 2;
     W_temp = max(0, W - alpha*gradW);
     F_cur  = squared_chord_matrices(M,W_temp*H);

   if alpha < 1e-15 % if no stepsize avaliable
     W_temp = W;    
       break;
   end
end%end while

W = W_temp;
end%EOF