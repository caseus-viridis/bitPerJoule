function [kappa, b, m, pciKappa, pciB, pciM] = mleMarginals(t, lambda)

% Estimate parameters from marginals

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

assert(all(t(:)>0), 'All ISIs need to be epositive.');
assert(all(lambda(:)>0), 'All rates need to be epositive.');

[phat, pci] = mle(t, 'distribution', 'gamma');
kappa = phat(1); pciKappa = pci(:, 1);
b = 1/phat(2); pciB = 1./pci(:, 2);

[phat, pci] = mle(lambda, 'pdf', @(lambda, m) pdfLambda(lambda, kappa, b, m), ...
    'start', mean(t.*lambda));
m = phat; pciM = pci;
