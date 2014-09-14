function [kappa, b, m, nll] = mleJoint(t, lambda, kappa_, b_, m_, tol)

% Estimate parameters from joint

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

if nargin<6, tol = 1e-12; end

assert(all(t(:)>0), 'All ISIs need to be epositive.');
assert(all(lambda(:)>0), 'All rates need to be epositive.');

nllF = @(param) -sum(log(pdfTLambda(t, lambda, param(1), param(2), param(3)))); % neg-log-likelihood
[param, nll] = fminsearch(nllF, [kappa_, b_, m_], optimset('TolX', tol));
kappa = param(1);
b = param(2);
m = param(3);
