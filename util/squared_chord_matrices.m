function D2_out = squared_chord_matrices(M,X) % squared-chordal distance between M and X
[~,numcol_X] = size(X);

if numcol_X < 1000
% a vector that stores l2 norm of each column of M
nMj = sqrt(sum(M.^2));
% a vector that stores l2 norm of each column of X
nXj = sqrt(sum(X.^2));
% the sum in squared-chordal distance
TheSum = sum(  diag(M'*X) ./ (nMj .* nXj)'  );

else % using for loop (inefficient in times but efficient on memory)
    TheSum = 0;
    for j = 1 : numcol_X
        Mj = M(:,j);
        Xj = X(:,j);
        scalar_prod = Mj'  *  Xj;
        norm_Mj     = norm(Mj);
        norm_Xj     = norm(Xj);
        TheSum      =  TheSum  +  scalar_prod / (norm_Mj*norm_Xj+eps);
    end
end

D2_out =  1 - TheSum/numcol_X ;
end%EOF
