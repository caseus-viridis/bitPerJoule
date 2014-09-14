function p = pdfTgivenLambda(t, lambda, m)

% Conditional density of postsyn. ISI given presyn. rate
% Note the difference between this implementation and Eqn. 13 of Berger &
% Levy 2010: m is assumed to be a real number (rather than an integer) no less than 1.  

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

assert(all(t(:)>0), 'All ISIs need to be epositive.');
assert(all(lambda(:)>0), 'All rates need to be epositive.');

p = (lambda.^m) .* (t.^(m-1)) .* exp(-lambda .* t) ...
    / gamma(m);
