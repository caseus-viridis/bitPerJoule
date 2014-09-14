% Test MLE of parameters of joint and marginal density functions

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

clear all; clc;

%% load example data
dataPath    = '../data/parsed';
recordName  = '080318F-XW053';

[t, lambda, n] = getDataFromRecord(fullfile(dataPath, [recordName, '.mat']));

%% rate estimates
m0 = mean(n);
rPost = length(t)/sum(t);
rPre = sum(n)/sum(t);

%% estimate parameters from marginals
[kappa_, b_, m_] = mleMarginals(t, lambda);

%% estimate parameters from joint
[kappa, b, m] = mleJoint(t, lambda, kappa_, b_, m_);

%% visualization
tRange          = [eps, 0.25];
lambdaRange     = [eps, 250];
tBinNum         = 128;
lambdaBinNum    = 128;
pRange          = [1e-6, 1e-0];
nRes            = 1e3;
t_              = linspace(tRange(1), tRange(2), nRes);
lambda_         = linspace(lambdaRange(1), lambdaRange(2), nRes);
[T_, Lambda_]   = meshgrid(t_, lambda_);

figure;
haJoint         = subplot(1, 2, 1); hold on;
p               = pdfTLambda(T_, Lambda_, kappa, b, m);
hJoint          = image(t_, lambda_, p, ...
    'CDataMapping', 'Scaled'); caxis([0, max(p(:))]); colorbar;
hScatter        = plot(t, lambda, 'ko');
set(haJoint, 'XDir', 'norm', 'YDir', 'norm', 'XLim', tRange, 'YLim', lambdaRange);
xlabel('t [s]', 'FontSize', 16);
ylabel('\lambda [s^{-1}]', 'FontSize', 16);
title(['Estimated from joint: \kappa = ', num2str(kappa), ...
    '; b = ', num2str(b), ' s^{-1}; m = ', num2str(m)], 'FontSize', 16);
haJoint_        = subplot(1, 2, 2); hold on;
p               = pdfTLambda(T_, Lambda_, kappa_, b_, m_);
hJoint_         = image(t_, lambda_, p, ...
    'CDataMapping', 'Scaled'); caxis([0, max(p(:))]); colorbar;
hScatter_       = plot(t, lambda, 'ko');
set(haJoint_, 'XDir', 'norm', 'YDir', 'norm', 'XLim', tRange, 'YLim', lambdaRange);
xlabel('t [s]', 'FontSize', 16);
ylabel('\lambda [s^{-1}]', 'FontSize', 16);
title(['Estimated from marginals: \kappa = ', num2str(kappa_), ...
    '; b = ', num2str(b_), ' s^{-1}; m = ', num2str(m_)], 'FontSize', 16);
