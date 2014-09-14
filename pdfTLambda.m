function p = pdfTLambda(t, lambda, kappa, b, m)

% Joint density of postsyn. ISI and presyn. rate
% Note the difference between this implementation and Eqns. 13 & 32 of Berger &
% Levy 2010: m is assumed to be a real number (rather than an integer) no less than 1.  

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

assert(all(t(:)>0), 'All ISIs need to be epositive.');
assert(all(lambda(:)>0), 'All rates need to be epositive.');

% p = b^kappa * (lambda-b).^(m-1-kappa) .* (t.^(m-1)) .* (lambda.^m) .* exp(-lambda .* t) ...
%     / gamma(kappa) / gamma(m-kappa) ...
%     .* heaviside(lambda - b);

p = pdfLambda(lambda, kappa, b, m) ...
    .* pdfTgivenLambda(t, lambda, m);
