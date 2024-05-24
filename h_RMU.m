function h = h_RMU(A,b,h) 
% one iteration of RMU update of column h in H
c        = A*h;
bh       = b'*h;
bc       = b'*c;
hc       = h'*c;
cc       = c'*c;
r1       = bh/hc;
grad_pos = (r1 + (bc/cc) )* c ;
grad_neg = r1 * c + b;
% Riemannian gradient descent
RG_step  = h .* grad_neg ./ grad_pos; 
h        = RG_step / sqrt(RG_step'*A*RG_step); % metric retraction
end%EOF
%% old way using tensor product
%{
c        = A*h;
bh       = b'*h;
hc       = h'*c;
c_tensor = c * c';
cc       = c'*c;

% Riemannian positive   grad_pos = (bh*c/hc)     +   (c_tensor/cc) * b ;
% Riemannian negative   grad_neg = (c_tensor/cc) * (bh*c/hc)    +   b;
Part_bhchc       = (bh*c/hc);
Part_c_tensor_cc = c_tensor/cc;

grad_pos = Part_bhchc     +   Part_c_tensor_cc * b ;
grad_neg = Part_c_tensor_cc * Part_bhchc    +   b;

% these should be the same
% c_tensor*b-(c'*b)*c
%  c_tensor*c - (c'*c)*c

% Riemannian gradient descent
RG_step = h .* grad_neg ./ grad_pos; 
h       = RG_step / sqrt(RG_step'*A*RG_step); % metric retraction
%}