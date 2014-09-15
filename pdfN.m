function p = pdfN(n, kappa, b, m, intOpt)

% Marginal density of presyn. number of spikes per postsyn. spike
% Note that n == t.*lambda.
% Use switch intOpt to choose which RV to integrate: true for t, false for
% lambda; default is false.

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

assert(all(n(:)>0), 'All spike numbers need to be epositive.');
if nargin < 5
    intOpt = false;
end

p = n;
if intOpt
    for i = 1 : numel(n)
        f = @(t) pdfTLambda(t, n(i)./t, kappa, b, m) ./ t;
        p(i) = integral(f, eps, n(i)/b);
    end
else
    for i = 1 : numel(n)
        f = @(lambda) pdfTLambda(n(i)./lambda, lambda, kappa, b, m) ./ lambda;
        p(i) = integral(f, b, Inf);
    end
end