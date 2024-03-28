function Del = GL_logdet(D, options)
%GL_logdet Graph learning with log det method.
% Ref: Discovering Structure by Learning Sparse Graphs
arguments
    D double
    options.beta = 14
end
% Initialization
    beta = options.beta;
    [n, m] = size(D);
    on = ones(1, n);
    I = eye(n);
    maskW = ones(n) - eye(n);

    % normalize data
    D = normalize(D, 2, 'center');
    D = D./sqrt((max(abs(D*D'./m), [], 'all')));

% Solving Structure Learning with CVX
    cvx_begin quiet
        variable Del(n, n) semidefinite;
        variable W(n, n) symmetric;
        variable s nonnegative;
        maximize log_det(Del) - trace(Del*(D*D')./m) - beta/m*norm(W, 1);
        subject to
            Del == diag(sum(W)) - W + I*s;
            W.*I == 0;
            W.*maskW >= 0;
    cvx_end
end

