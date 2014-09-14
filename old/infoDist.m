function x = infoDist(kappa, m)
% Xin Wang 2011
x = ((log(gamma(kappa))-kappa*psi(0,kappa)+kappa)-(log(gamma(m))-m.*psi(0,m)+m));
x(m<kappa) = 0;