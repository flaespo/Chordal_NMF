function [W,H,F,T,o] = Chordal(M,W,H,Iter,o) % Chordal-NMF by BCD
% === Input ===
% M,W,H  m-by-n matrix to factorize, initial m-by-r W, initial r-by-n H
% Iter   num of iterarions
% WIter  number of iterations for updating W
% === OUTPUT===
% W,H    output W,H
% F,T    F(W,H) for each k,  time stamp for each k
% o      output struct, contains the algo_name
%% Input handling

if strcmp(o.algoH,'EPG')
  o.algoname = 'EPG-h';
elseif strcmp(o.algoH,'RMU')
  o.algoname = 'RMU-h';
elseif strcmp(o.algoH,'RADMM')
  o.algoname = 'RADMM-h';
elseif strcmp(o.algoH,'RALM')
  o.algoname = 'RALM-h';
end

if strcmp(o.algoW, 'EPG')
  o.algoname = strcat(o.algoname,', EPG-W');
elseif strcmp(o.algoW, 'FastEPG')
  o.algoname = strcat(o.algoname,', FastEPG-W');
elseif strcmp(o.algoW, 'consensusRMU')
  o.algoname = strcat(o.algoname,', consensusRMU-W');
elseif strcmp(o.algoW, 'FracProg')
  o.algoname = strcat(o.algoname,', FracProg-W');
elseif strcmp(o.algoW, 'greedy')
  o.algoname = strcat(o.algoname,', greedyRMU-W');
end
%%
n            = size(M,2);
timeSubtract = 0; % total time to be subtracted on computing function value
F            = nan(Iter,1); % objective function value
T            = F; % time stamp
timeStart    = tic;
[m,r]        = size(W);
n            = size(H,2);
%% main loop
for k = 1 : Iter
%%update h
 WtW = W'*W;
 WtM = W'*M;
     if strcmp(o.algoH,'RMU')        % RMU update for each column h
        for j=1:n 
          H(:,j) = h_RMU(WtW,WtM(:,j),H(:,j));  
        end%endFor
    
     elseif strcmp(o.algoH,'EPG')     % Euclidean Projected Gradient descent on H
        for j=1:n 
          H(:,j) = h_EPG(W,H(:,j),WtM(:,j),M(:,j),1);
        end%endFor

     elseif strcmp(o.algoH,'RADMM')   % R-ADMM update for each column h
        for j=1:n 
          H(:,j) = h_RADMM(WtW,WtM(:,j),H(:,j),M(:,j),W,1);
        end%endFor
    
     elseif strcmp(o.algoH,'RALM')    % R-ALM update for each column h
        for j=1:n 
          H(:,j) = h_RALM(WtW,WtM(:,j),H(:,j),M(:,j),W,1);
        end%endFor
     end
%% update W
     if strcmp(o.algoW, 'EPG')
          W = W_EPG(M,W,H,m,n,r);
     elseif strcmp(o.algoW, 'FastEPG')
          W = W_FastEPG(M,W,H,m,n,r);
     elseif strcmp(o.algoW, 'consensusRMU')
          for j = 1 : 50
          W = W_consensusRMU(M,W,H,m,n,r);
          end
     elseif strcmp(o.algoW, 'FracPrgo')
        MHt = M*Ht;
          W = W_FracProg(M,W,H,n,MHt);
     elseif strcmp(o.algoW, 'greedy')
        MHt = M*Ht;
          W = W_greedyRMU(M,W,H,n,r); 
     end
%% Computing function values
tStuff       = tic; % start time before computung function value
    F(k)     = squared_chord_matrices(M,W*H);
timeSubtract = timeSubtract + toc(tStuff);
        T(k) = toc(timeStart) - timeSubtract;
if mod(k,25)==0 disp(strcat(o.algoname,', step'," ",num2str(k)));end
end%endFOR
end%EOF
