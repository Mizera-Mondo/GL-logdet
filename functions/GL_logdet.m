function [outputArg1,outputArg2] = GL_logdet(D, options)
%GL_LOGDET Graph learning with log det method.
arguments
    D double
    options.beta = 14
end
% Initialization
    [n, m] = size(D);
    % normalize data
    D = normalize(D, 2, 'center');
    D = D./sqrt((max(abs(D*D'./m), [], 'all')));
end

