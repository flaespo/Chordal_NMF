function grad_out = grad_squared_chord_matrices(M,X)
% Old code for the plot
% Need to check!

[m,n] = size(X);

grad_out = zeros(m,n);
    for t = 1:n
        n2 = norm(M(:,t),2);
        %t_norm = 2/(n2^2);
        t_norm = 1/(n*(n2^2));
        MXt = M(:,t).*X(:,t);
        sumMXt = sum(MXt);
        Xt2 = X(:,t).^2;
        sumXt2 = sum(Xt2);
        DL1 = sumXt2.^(3/2);
        NL1 =  sumMXt*X(:,t)-M(:,t)*sumXt2;
        grad_out(:,t) = t_norm*(NL1/DL1);
        % for a = 1:nX
        %     NL1 =  sumMXt*X(a,t)-M(a,t)*sumXt2;
        %     grad(a,t) = t_norm*(NL1/DL1);
        % end
    end%end for
end%EOF
