%% param
clear all;
alpha = 2;
beta = 2;
tol = 1e-6;

b = 10;

rho = 1;
sigma = 0;

kappa = 0:0.1:1;
m = 0 : 0.01 : 10;

%%
I = zeros(length(kappa), length(m));
Is = I;
Ij = I;
E = I;
for i = 1 : length(kappa)
    for j = 1 : length(m)
        [Ij(i, j), I(i, j), E(i, j)] = getIj(m(j), kappa(i), rho, sigma);
        Is(i, j) = I(i, j) /kappa(i);
    end
    i
end

%%
figure;
h(1) = subplot(2, 2, 1); hold on;
plot(h(1), m, E); plot(h(1), m, E(end, :), 'k');
xlabel('m');
ylabel('E');
h(2) = subplot(2, 2, 2); hold on;
plot(h(2), m, I); plot(h(2), m, I(end, :), 'k');
xlabel('m');
ylabel('I');
h(3) = subplot(2, 2, 3); hold on;
plot(h(3), m, Is); plot(h(3), m, Is(end, :), 'k');
xlabel('m');
ylabel('Is/b');
h(4) = subplot(2, 2, 4); hold on;
plot(h(4), m, Ij); plot(h(4), m, Ij(end, :), 'k');
xlabel('m');
ylabel('Ij');

