function p = pdfT(t, kappa, b)

% Marginal density of postsyn. ISI

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

assert(all(t(:)>0), 'All ISIs need to be epositive.');

p = b^kappa * t.^(kappa-1) .* exp(-b*t) ...
    / gamma(kappa);
