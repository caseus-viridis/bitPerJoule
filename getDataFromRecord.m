function [t, lambda, n, tSpk, tEPSP, isRelayed] = getDataFromRecord(matFile)

% Load from processed data 3 RVs: postsyn. ISI (t), presyn. rate (lambda),
% presyn. number of spikes per postsyn. spike (n); 
% Note that n == t.*lambda.

% Xin Wang <xinw@salk.edu>
% Copyright 2014, CNL-S, The Salk Institute for Biological Studies

s = load(matFile);
s = s.dat;
idx = s.tSpk>s.stimTimeStamp.onsetTime & s.tSpk<s.stimTimeStamp.offsetTime;
tSpk = s.tSpk(idx);
idx = s.tEPSP>s.stimTimeStamp.onsetTime & s.tEPSP<s.stimTimeStamp.offsetTime;
isRelayed = s.isRelayed(idx);
tEPSP = s.tEPSP(idx);
t = diff(tSpk);
n = diff(find(isRelayed));
lambda = n./t;
