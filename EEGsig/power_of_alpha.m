function [pow_alpha,w]=power_of_alpha(x)
[C,L] = wavedec(x,5,'db4');
Alpha = wrcoef('d',C,L,'db4',4);          %ALPHA
[pow_alpha,w] = periodogram(Alpha);
end