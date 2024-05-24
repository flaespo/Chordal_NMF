function h = h_EPG(W,h,Wtmj,mj,alpha)
Ir      = eye(size(W,1));
norm_mj = norm(mj);
Wh      = W*h;
nWh     = sqrt(Wh'*Wh);
a       = alpha;

%size((Wh*Wh')/nWh)
%size(Ir)
grad_h  = W'*(((Wh*Wh')/nWh - Ir))*mj/nWh;
phi_old = 1-(Wtmj'*h)/(norm_mj*nWh); % cost at h_old

       h_temp  = h - a*grad_h; % updated h
       phi_cur = 1-(Wtmj'*h_temp)/(norm_mj*norm(W*h_temp)); % cost after update
       while phi_cur > phi_old % if update increase cost
             a       = a/2; % drop stepsize
             h_temp  = h - a*grad_h; % update
             phi_cur = 1-(Wtmj'*h_temp)/(norm_mj*norm(W*h_temp));
             if a < 1e-15
                 h_temp = h;
                 break;
             end
       end
h = h_temp;
end