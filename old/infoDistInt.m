function x = infoDistInt(x, kappa, b, m)
% Jackie Xing & Xin Wang 2011
if m == kappa + 1
    x = (-( (x.^(-kappa-1)) ...
        .* (log(b^kappa)+log((gamma(m)/gamma(kappa)))) ...
        + (x.^(-kappa-1)) ...
        .* ((kappa-m)*psi(0,m)- kappa*log(x) + m*(x-b)./x ))...
    *b^kappa* (gamma(m)/(gamma(kappa)*gamma(m-kappa))) );
else
    x = (-(((x-b)./x).^(m-kappa-1)) ...
        .* ( (x.^(-kappa-1)) ...
        .* (log(b^kappa) +log((gamma(m)/gamma(kappa)))) ...
        + (x.^(-kappa-1)) .* ((kappa-m)*psi(0,m)- kappa*log(x)+ m*(x-b)./x ))...
    *b^kappa* (gamma(m)/(gamma(kappa)*gamma(m-kappa))) );
end