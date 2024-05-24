function [M, n_col_M] = normalize(M)
% perform M(:,j) = M(:,j)/norm(M(:,j));

n_col_M = sqrt(sum(M.^2));

if size(M,2) < 1e4
M = M * diag( 1 ./ n_col_M ); 
else
     for j = 1 : size(M,2)
       M(:,j) = M(:,j) / n_col_M(j); 
     end
end

end