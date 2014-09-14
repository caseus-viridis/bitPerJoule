%% param
clear all;
alpha = 2;
beta = 2;
tol = 1e-6;

kappa = 0.6;
b = 10;

rho = 2.^(-3:3);
% rho = 1;
% sigma = 0:1:6;
% sigma = 0;

% rho = 10.^(-1:0.02:1);
sigma = 0:0.1:10;

m = 0 : 0.01 : 10;

%%
% figure;
% h(1) = subplot(2, 2, 1); hold on;
% h(2) = subplot(2, 2, 2); hold on;
% h(3) = subplot(2, 2, 3); hold on;
% h(4) = subplot(2, 2, 4); hold on;
mMax = zeros(length(rho), length(sigma));
IjMax = mMax;
for i = 1 : length(rho)
for j = 1 : length(sigma)
    [Ij, I, E] = getIj(m, kappa, rho(i), sigma(j));
    Is = I *b/kappa;
    [mMax(i, j), IjMax(i, j)] = mMaxIj(kappa, rho(i), sigma(j), tol);

%     plot(h(1), m, E, 'b-');
%     xlabel('m');
%     ylabel('E');
%     title(h(1), ['\rho = ', num2str(rho), '; \sigma = ', num2str(sigma), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
%     plot(h(2), m, I, 'b-');
%     xlabel('m');
%     ylabel('I');
%     title(h(2), ['\rho = ', num2str(rho), '; \sigma = ', num2str(sigma), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
%     plot(h(3), m, Is, 'b-');
%     xlabel('m');
%     ylabel('Is');
%     title(h(3), ['\rho = ', num2str(rho), '; \sigma = ', num2str(sigma), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
%     plot(h(4), m, Ij, 'b-', mMax(i, j), IjMax(i, j), 'ro');
%     xlabel('m');
%     ylabel('Ij');
%     title(h(4), ['\rho = ', num2str(rho), '; \sigma = ', num2str(sigma), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
end
i
end