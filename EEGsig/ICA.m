function [Zica, W, T, mu] = ICA(Z,r)

% Syntax:       Zica = ICA(Z,r)              

mu = mean(Z,2);
T = sqrtm(inv(cov(Z')));
Zcw = T * bsxfun(@minus,Z,mu);
% Max-kurtosis ICA
[W, ~, ~] = svd(bsxfun(@times,sum(Zcw.^2,1),Zcw) * Zcw');
Zica = W(1:r,:) * Zcw;