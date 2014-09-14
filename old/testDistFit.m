dataPath = '/home/xinw/priv/Collaborations/Jackie Xing/';
% dataPath = '/home/xinw/public_html/dataForJacky/';
dataFile = dir([dataPath, '*.mat']);
figure;
for i = 1 : length(dataFile)
    s = load([dataPath, dataFile(i).name]);
    s = s.dat;
    tSpk = s.tSpk(s.tSpk>s.stimTimeStamp.onsetTime & s.tSpk<s.stimTimeStamp.offsetTime);
    isRelayed = s.isRelayed(s.tEPSP>s.stimTimeStamp.onsetTime & s.tEPSP<s.stimTimeStamp.offsetTime);
    tEPSP = s.tEPSP(s.tEPSP>s.stimTimeStamp.onsetTime & s.tEPSP<s.stimTimeStamp.offsetTime);
    dataISI = diff(tSpk);
    dataLambda = diff(find(isRelayed))./diff(tSpk);
    mEst = length(tEPSP)/length(tSpk);
%     [phat, pci] = gamfit(dataISI(dataISI>0));
    [phat, pci] = mle(dataISI(dataISI>0), 'distribution', 'gamma');
    kappa = phat(1);
    b = 1/phat(2);
    dx = 0.01;
    x = dx/2:dx:1;
    yy = hist(dataISI, x)/dx/length(dataISI);
    xx = [x(1:end-1); x(2:end)];
    yy = [yy(1:end-1); yy(1:end-1)];
    yy(yy==0) = 1e-9;
    y = pdf('gamma', x, kappa, 1/b);
    
    dLambda = 1;
    lambda = dLambda/2 : dLambda : 200;
    fLambda = hist(dataLambda, lambda)/dLambda/length(dataLambda);
    
    h1 = subplot(1, 3, 1); cla;
    plot(xx(:), yy(:), 'k-', x, y, 'r');
    xlabel('T (s)');
    ylabel('f_T');
    title([dataFile(i).name(1:end-4), '  \kappa = ', num2str(kappa), '  b = ', num2str(b), '  m_{est} = ', num2str(mEst)]);
    set(h1, 'XScale', 'linear', 'YScale', 'log');
    
    h2 = subplot(1, 3, 2); cla;
    plot(lambda, fLambda, 'k', 'LineWidth', 2); hold on;
    plot(lambda, distLambda(lambda, kappa, b, mEst), 'r-');
    clear('LL');
    for m = 1 : 10
        plot(lambda, distLambda(lambda, kappa, b, m), 'b-');
        temp = distLambda(dataLambda, kappa, b, m);
        temp = temp(temp>0);
        LL(m) = mean(log(temp));
    end
    xlabel('\lambda (s^{-1})');
    ylabel('f_{\Lambda}');
    set(h2, 'XScale', 'log', 'YScale', 'linear');
	
    h3 = subplot(1, 3, 3); cla;
    plot(1:length(LL), LL, 'bo-');
    xlabel('m');
    ylabel('Log likelihood');
    
    mMaxData(dataLambda, kappa, b, mEst, 1e-9);
    pause;
end
