function Wavg = W_consensusRMU(M,W,H,m,n,r)
% one iteration of consensus_RMU to update W
Wavg = zeros(m,r);
for j = 1 : n
 hj = H(:,j);
 mj = M(:,j);
 Aj = hj * hj';
 Bj = mj * hj';
 Wj = one_block_RMU_updtW_one_iter(W,Aj,Bj);
 Wavg = Wavg + Wj;
end
 Wavg = Wavg/n;
end %EOF
%%
function W = one_block_RMU_updtW_one_iter(W,A,B)
% RMU on W for one manifold
 C  = W*A;
 BW = trace(B'*W);
 BC = trace(B'*C);
 WC = trace(W'*C);
 CC = trace(C'*C)^2;
      r1 = BW/WC;
grad_pos = (r1 + (BC/CC))*C;
grad_neg = B + r1 * C;
% Riemannian gradient descent
RG_step = W .* grad_neg ./ grad_pos; 
W       = RG_step / sqrt(trace(RG_step'*(RG_step*A))); % metric retraction
%F(k)    = 1- M(:,1)'*W*Hini(:,1)/norm(W*Hini(:,1)); % initial object value
end
