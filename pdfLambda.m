function p = pdfLambda(lambda, kappa, b, m)

% Marginal density of presyn. rate

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

assert(all(lambda(:)>0), 'All rates need to be epositive.');

p = b^kappa * gamma(m) / gamma(kappa) / gamma(m-kappa) ...
    * (lambda-b).^(m-1-kappa) ./ (lambda.^m) ...
    .* heaviside(lambda - b);
