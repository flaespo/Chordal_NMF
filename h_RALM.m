function h = h_RALM(WtW,Wtmj,hj,mj,W, alpha )
% update h by RALM
norm_mj = norm(mj); % norm of jth column of M
h       = hj;       % h variable
a       = alpha;    % stepsize

       phi_old = 1-(Wtmj'*h)/(norm_mj*norm(W*h)); % cost at h_old
       h_temp  = updt_h_RALM(h,W,WtW,Wtmj,a); % updated h
       phi_cur = 1-(Wtmj'*h_temp)/(norm_mj*norm(W*h_temp)); % cost after update
       while phi_cur > phi_old % if update increase cost
             a       = a/2; % drop stepsize
             h_temp  = updt_h_RALM(h,W,WtW,Wtmj,a);
             phi_cur = 1-(Wtmj'*h_temp)/(norm_mj*norm(W*h_temp));
             if a < 1e-15
                 h_temp = h;
                 break;
             end
       end
             h = h_temp;
end%EOF
%%
function h = updt_h_RALM(h,W,WtW,Wtmj, alpha)
lambda = zeros(size(h));
rho    = 10;
for i = 1 : 1
 h      = updt_h_RALM_xstep(h,W,WtW,Wtmj, alpha, rho, lambda);
 lambda = lambda - rho*h;
end
end%EOF
%%
function h = updt_h_RALM_xstep(h,W,WtW,Wtmj, alpha, rho, lambda)
  % Euclidean gradient 
    Wh            = W*h;    % vector Wh
    nWh2          = Wh'*Wh; % norm of Wh squared
    WtWh          = WtW*h;
    mjWh          = h'*Wtmj;
    grad_Euclid_f = ( mjWh * WtWh - nWh2 * Wtmj )  /   (   nWh2^(3/2)   ); % gradient of f part
    grad_Euclid_g = max(0,rho*h - lambda); % gradient of penalty part
    grad_Euclid   = grad_Euclid_f + grad_Euclid_g;

  % Riemannian gradient
    WtWhhtWtW_norm = (WtWh * WtWh')/(norm(WtWh)^2);
    grad_Rieman    = grad_Euclid - WtWhhtWtW_norm * grad_Euclid; % ( Ir - WtWhhtWtW_norm ) * grad;

  % Riemannian gradient descent
    RG_step        = -alpha * grad_Rieman;   % Riemanian gradient step

  % Retraction using Exp
    norm_e = (WtW*RG_step)'*RG_step;
    h      = cos(norm_e)*h + sin(norm_e)/norm_e*RG_step; % retraction  
end%EOF