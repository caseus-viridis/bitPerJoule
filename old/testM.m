%% param
clear all;
alpha = 2;
beta = 2;
tol1 = 1e-6;
tol2 = 1e-6;

kappa = 0.6;
b = 10;

rho = 1;
sigma = 0;

m = kappa : 0.1 : 6;

%%
E = b/kappa * (1+rho*m + sigma);
I = zeros(size(m));
I_a = zeros(size(m));
for i = 1 : length(m)
    I(i) = infoInt(kappa, b, m(i), alpha, beta, tol1, tol2);
    I_a(i) = infoDist(kappa, m(i));
end
Is = I *b/kappa;
Is_a = I_a *b/kappa;
Ij = I ./ E;
Ij_a = I_a ./ E;

%%
figure;
subplot(2, 2, 1);
plot(m, E, 'ko-');
xlabel('m');
ylabel('E');
title(['\rho = ', num2str(rho), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
subplot(2, 2, 2);
plot(m, I, 'ko-', m, I_a, 'r-');
xlabel('m');
ylabel('I');
title(['\rho = ', num2str(rho), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
subplot(2, 2, 3);
plot(m, Is, 'ko-', m, Is_a, 'r-');
xlabel('m');
ylabel('Is');
title(['\rho = ', num2str(rho), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);
subplot(2, 2, 4);
plot(m, Ij, 'ko-', m, Ij_a, 'r-');
xlabel('m');
ylabel('Ij');
title(['\rho = ', num2str(rho), '; \kappa = ', num2str(kappa), '; b = ', num2str(b), ';']);

%%
clc;
[~, idx] = max(Ij);
disp(m(idx));