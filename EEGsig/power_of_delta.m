function [pow_delta,w]=power_of_delta(x)
[C,L] = wavedec(x,5,'db1');                   
delta = wrcoef('a',C,L,'db1',5);          %DELTA
[pow_delta,w] = periodogram(delta);
end