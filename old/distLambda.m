function pdf = distLambda(x, kappa, b, m)

pdf = b^kappa * gamma(m) / gamma(kappa) / gamma(m-kappa) ...
    * (x-b).^(m-kappa-1) ./ x.^m; 
pdf(x<b) = 0;