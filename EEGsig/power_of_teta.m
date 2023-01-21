function [pow_teta,w]=power_of_teta(x)
[C,L] = wavedec(x,5,'db1');
teta = wrcoef('d',C,L,'db1',5);          %THETA
[pow_teta,w] = periodogram(teta);
end