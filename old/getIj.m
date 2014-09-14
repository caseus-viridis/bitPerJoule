function [Ij, I, E] = getIj(m, kappa, rho, sigma)
E = 1+rho*m+sigma;
I = infoDist(kappa, m);
Ij = I./E;