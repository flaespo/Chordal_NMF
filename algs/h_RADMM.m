function h = h_RADMM(WtW,Wtmj,hj,mj,W, alpha )
% update h by RADMM
norm_mj = norm(mj); % norm of jth column of M
h       = hj;       % h variable
a       = alpha;    % stepsize

       phi_old = 1-(Wtmj'*h)/(norm_mj*norm(W*h)); % cost at h_old
       h_temp  = updt_h_RADMM(h,W,WtW,Wtmj,a); % updated h
       phi_cur = 1-(Wtmj'*h_temp)/(norm_mj*norm(W*h_temp)); % cost after update
       while phi_cur > phi_old % if update increase cost
             a       = a/2; % drop stepsize
             h_temp  = updt_h_RADMM(h,W,WtW,Wtmj,a);
             phi_cur = 1-(Wtmj'*h_temp)/(norm_mj*norm(W*h_temp));
             if a < 1e-15
                 h_temp = h;
                 break;
             end
       end
             h = h_temp;
end%EOF
%%
function h = updt_h_RADMM(h,W,WtW,Wtmj,alpha)
rho    = 0.999999*sqrt(2);
lambda = h;
y      = h;
 for i = 1:10
 h     = updt_h_RALM_xstep(h,W,WtW,Wtmj,alpha,lambda,y, rho);
 y     = max(0, lambda/rho + h);
 lambda= lambda + rho*(h-y);
 end
end%EOF
%%
function h = updt_h_RALM_xstep(h,W,WtW,Wtmj,alpha,lambda,y,rho)
% Euclidean gradient 
  Wh    = W*h;    % vector Wh
  nWh2  = Wh'*Wh; % norm of Wh squared
  WtWh  = WtW*h;
  nabla = ( (h'* Wtmj) * WtWh - nWh2 * Wtmj )  /  nWh2^(3/2);
  nabla = nabla + lambda + rho*(h-y);
% Riemannian gradient
  grad  = nabla - (WtWh * WtWh')/(norm(WtWh)^2) * nabla; % ( Ir - WtWhhtWtW_norm ) * grad;
% Riemannian gradient descent
RG_step = -alpha * grad;   % Riemanian gradient step
% Retraction using Exp
 norm_e = (WtW*RG_step)'*RG_step;
  h     = cos(norm_e)*h + sin(norm_e)/norm_e*RG_step; % retraction  
end%EOF
