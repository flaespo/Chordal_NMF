function Fx = cal_phi(h,W,mj)
Wh = W*h;
Fx = 1  - (mj'*Wh)/ (norm(mj)*norm(Wh));
end%EOF