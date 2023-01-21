function [pow_beta,w]=power_of_beta(x)
[C,L] = wavedec(x,5,'db1');
beta  = wrcoef('d',C,L,'db1',3);          %BETA
[pow_beta,w] = periodogram(beta);
end