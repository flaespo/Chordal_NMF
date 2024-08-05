function W = W_EPG(M,W,H,m,n,r)
% one iteration of Euclidean projected gradient on W

% initial stepsize for line search
alpha = 1; 
% initial function value for doing the line search
F_pre = squared_chord_matrices(M,W*H);

% computing the Euclidean gradient
nablaW = zeros(m,r);
for j = 1 : n
          hj = H(:,j);
          mj = M(:,j);
          Aj = hj*hj';
          Bj = mj*hj';
          WA = W*Aj; 
        nWWA = sqrt(trace(W'*WA));
     nablaWj = trace(W'*Bj)*WA/nWWA^3 - Bj/nWWA;
      nablaW = nablaW + nablaWj;
end
nablaW = nablaW /n;

% Line search
     W_temp = max(0, W - alpha*nablaW);
     F_cur  = squared_chord_matrices(M,W_temp*H);
while F_cur > F_pre
      alpha = alpha / 2;
     W_temp = max(0, W - alpha*nablaW);
     F_cur  = squared_chord_matrices(M,W_temp*H);

   if alpha < 1e-15 % if no stepsize avaliable
     W_temp = W;    
       break;
   end
end%end while

W = W_temp;
end%EOF