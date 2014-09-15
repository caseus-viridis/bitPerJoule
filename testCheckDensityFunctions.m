% Check implemented density functions:
% p = pdfT(t, kappa, b)
% p = pdfLambda(lambda, kappa, b, m)
% p = pdfTgivenLambda(t, lambda, m)
% p = pdfTLambda(t, lambda, kappa, b, m)

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

clear all; 

%% parameters
kappa           = 0.7; 
b               = 10;
m               = 3; % kappa : 0.1 : 10;

%% ranges and steps of RVs
tRange          = [0, 1e0] + eps;
lambdaRange     = [0, 1e3] + eps;
tStep           = range(tRange)/1e3;
lambdaStep      = range(lambdaRange)/1e3;

t_              = linspace(tRange(1), tRange(2), ...
                    ceil(range(tRange)/tStep));
lambda_         = linspace(lambdaRange(1), lambdaRange(2), ...
                    ceil(range(lambdaRange)/lambdaStep));
n_              = t_ .* lambda_;

[t, lambda]     = meshgrid(t_, lambda_);

%% compute the densities
pT              = pdfT(t_, kappa, b);
pLambda         = pdfLambda(lambda_, kappa, b, m);
pTgivenLambda   = pdfTgivenLambda(t, lambda, m);
pTLambda        = pdfTLambda(t, lambda, kappa, b, m);
pN              = pdfN(n_, kappa, b, m);

%% check normalization
zT              = integral(@(t) pdfT(t, kappa, b), ...
                    eps, 1e4, 'AbsTol', 1e-9);
zLambda         = integral(@(lambda) pdfLambda(lambda, kappa, b, m), ...
                    eps, 1e4, 'AbsTol', 1e-9);
zN              = integral(@(n) pdfN(n, kappa, b, m), ...
                    eps, 1e4, 'AbsTol', 1e-9);
zTgivenLambda   = zeros(size(lambda_));
for i = 1 : length(lambda_)
    zTgivenLambda(i) = integral(@(t) pdfTgivenLambda(t, lambda_(i), m), ...
        eps, 1e4, 'AbsTol', 1e-9);
end

%% marginalize the joint on postsyn. ISI and check against pT
pT_ = pT;
for i = 1 : length(t_)
    f = @(lambda) pdfTLambda(t_(i), lambda, kappa, b, m);
    pT_(i) = integral(f, eps, 1e4, 'AbsTol', 1e-9);
end
