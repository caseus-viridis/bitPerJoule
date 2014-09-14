%%
clear all;
lambda = 1;
tau = 1./(0:16);
A = 1./(1:16);
n = 2^27;
rndSeed = 0;

%% presyn
rng(rndSeed, 'twister');
isiPre = exprnd(1/lambda, [1, n]);
tPre = cumsum(isiPre);

%% postsyn
for i = 1 : length(tau)
    for j = 1 : length(A)
        tic;
        mu = false(1, n);
        V = zeros(1, n+1);
        V(1) = A;
        for i = 1 : length(isiPre)
            V(i+1) = A + V(i)*exp(-isiPre(i)/tau);
            if V(i+1) >= 1
                mu(i) = true;
                V(i+1) = 0;
            end
        end
        tPost = tPre(mu);
        isiPost = diff(tPost);
        mPre = diff(find(mu));
        lambdaPre = mPre./isiPost;
        toc
    end
end

%%
% dt = 1e-4;
% T = 600;
% t = 0 : dt : T;
% rhoIn = poissrnd(lambda*dt, size(t));
% rhoOut = zeros(size(t));
% 
% %%
% V = zeros(size(t));
% I = zeros(size(t));
% for i = 2 : length(t)
%     V(i) = V(i-1) - V(i-1)*dt/tau;
%     if rhoIn(i) > 0
%         V(i) = V(i) + A;
%     end
%     if V(i) > theta
%         rhoOut(i) = rhoOut(i) + 1;
%         V(i) = 0;
%     end
% end
