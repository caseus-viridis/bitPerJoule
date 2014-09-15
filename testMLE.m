% Test MLE of parameters of joint and marginal density functions

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

clear all; clc;

%% load example data
dataPath    = '../data/parsed';
recordName  = '080318F-XW053';

[t, lambda, n] = getDataFromRecord(fullfile(dataPath, [recordName, '.mat']));

%% rate estimates
m0                  = mean(n);
rPost               = length(t)/sum(t);
rPre                = sum(n)/sum(t);

%% estimate parameters from marginals
[kappa_, b_, m_]    = mleMarginals(t, lambda);

%% estimate parameters from joint
[kappa, b, m]       = mleJoint(t, lambda, kappa_, b_, m_);

%% visualization
tRange              = [eps, 0.25];
lambdaRange         = [eps, 250];
nRange              = [eps, 50];
tBinNum             = 128;
lambdaBinNum        = 128;
nBinNum             = 128;
pRange              = [1e-6, 1e-0];
nRes                = 1e3;
t_                  = linspace(tRange(1), tRange(2), nRes);
lambda_             = linspace(lambdaRange(1), lambdaRange(2), nRes);
n_                  = linspace(nRange(1), nRange(2), nRes);
[T_, Lambda_]       = meshgrid(t_, lambda_);

%---------------------------------------------------------------------------------------------
figure;
%---------------------------------------------------------------------------------------------
haJoint             = subplot(2, 6, 1:3); hold on;
p                   = pdfTLambda(T_, Lambda_, kappa, b, m);
hJoint              = image(t_, lambda_, p, ...
    'CDataMapping', 'Scaled'); caxis([0, max(p(:))]); colorbar;
hScatter            = plot(t, lambda, 'ko');
set(haJoint, 'XDir', 'norm', 'YDir', 'norm', 'XLim', tRange, 'YLim', lambdaRange);
xlabel('t [s]', 'FontSize', 16);
ylabel('\lambda [s^{-1}]', 'FontSize', 16);
title(['Estimated from joint: \kappa = ', num2str(kappa), ...
    '; b = ', num2str(b), ' s^{-1}; m = ', num2str(m)], 'FontSize', 16);
%---------------------------------------------------------------------------------------------
haJoint_            = subplot(2, 6, 4:6); hold on;
p                   = pdfTLambda(T_, Lambda_, kappa_, b_, m_);
hJoint_             = image(t_, lambda_, p, ...
    'CDataMapping', 'Scaled'); caxis([0, max(p(:))]); colorbar;
hScatter_           = plot(t, lambda, 'ko');
set(haJoint_, 'XDir', 'norm', 'YDir', 'norm', 'XLim', tRange, 'YLim', lambdaRange);
xlabel('t [s]', 'FontSize', 16);
ylabel('\lambda [s^{-1}]', 'FontSize', 16);
title(['Estimated from marginals: \kappa = ', num2str(kappa_), ...
    '; b = ', num2str(b_), ' s^{-1}; m = ', num2str(m_)], 'FontSize', 16);
%---------------------------------------------------------------------------------------------
haT                 = subplot(2, 6, 7:8); hold on;
p                   = pdfT(t_, kappa, b);
p_                  = pdfT(t_, kappa_, b_);
[~, ~, xx, yy]      = lebesgueFreqHist(t, tBinNum);
hDataTJoint         = plot(xx, yy, 'k-');
hTJoint             = plot(t_, p, 'r-');
hTJoint_            = plot(t_, p_, 'b-');
set(haT, 'Box', 'on', 'XLim', tRange, 'YScale', 'log', ...
    'YLim', [10^floor(log10(min(yy(xx>tRange(1)&xx<tRange(2))))), ...
    10^ceil(log10(max(yy(xx>tRange(1)&xx<tRange(2)))))]);
xlabel('t [s]', 'FontSize', 16);
ylabel('p(t) [s^{-1}]', 'FontSize', 16);
title({'Black: data', 'Blue: estimated from marginals', 'Red: estimated from joint'}, ...
    'FontSize', 16);
%---------------------------------------------------------------------------------------------
haLambda            = subplot(2, 6, 9:10); hold on;
p                   = pdfLambda(lambda_, kappa, b, m);
p_                  = pdfLambda(lambda_, kappa_, b_, m_);
[~, ~, xx, yy]      = lebesgueFreqHist(lambda, lambdaBinNum);
hDataLambdaJoint    = plot(xx, yy, 'k-');
hLambdaJoint        = plot(lambda_, p, 'r-');
hLambdaJoint_       = plot(lambda_, p_, 'b-');
set(haLambda, 'Box', 'on', 'XLim', lambdaRange, 'YScale', 'linear');
xlabel('\lambda [s^{-1}]', 'FontSize', 16);
ylabel('p(\lambda) [s]', 'FontSize', 16);
title({'Black: data', 'Blue: estimated from marginals', 'Red: estimated from joint'}, ...
    'FontSize', 16);
%---------------------------------------------------------------------------------------------
haN                 = subplot(2, 6, 11:12); hold on;
p                   = pdfN(n_, kappa, b, m);
p_                  = pdfN(n_, kappa_, b_, m_);
xx                  = 1 : nRange(2);
yy                  = hist(n, xx)/length(n);
hDataNJoint         = stem(xx, yy, 'k-');
hNJoint             = plot(n_, p, 'r-');
hNJoint_            = plot(n_, p_, 'b-');
set(haN, 'Box', 'on', 'XLim', nRange);
xlabel('n = {\lambda}t', 'FontSize', 16);
ylabel('P(n) (for data) and p(n) (for estimates)', 'FontSize', 16);
title({'Black: data', 'Blue: estimated from marginals', 'Red: estimated from joint'}, ...
    'FontSize', 16);

