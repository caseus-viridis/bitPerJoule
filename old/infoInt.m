function y = infoInt(kappa, b, m, alpha, beta, tol1, tol2)
y = 0;
loBnd = b;
yNow = 0; 
n = 1;
x = loBnd * beta.^((0:n)/n);
dy = trapz(x, infoDistInt(x, kappa, b, m));
dyPrev = y;
while abs((dy-dyPrev)/dyPrev) > tol1
    n = n * alpha;
    x = loBnd * beta.^((0:n)/n);
%     x(1) = loBnd * beta^1e-15;
    dyPrev = dy;
    dy = trapz(x, infoDistInt(x, kappa, b, m));
end
y = y + dy;
nCol = n;

while abs(dy/y) > tol2
    loBnd = loBnd * beta;
    n = 1;
    x = loBnd * beta.^((0:n)/n);
    dy = trapz(x, infoDistInt(x, kappa, b, m));
    dyPrev = y;
    while abs((dy-dyPrev)/dyPrev) > tol1
        n = n * alpha;
        x = loBnd * beta.^((0:n)/n);
        dyPrev = dy;
        dy = trapz(x, infoDistInt(x, kappa, b, m));
    end
    y = y + dy;
    nCol = [nCol, n];
end

disp(['Integration finished: upper-bound = ', num2str(loBnd*beta), '; n = [', num2str(nCol), '];']);

