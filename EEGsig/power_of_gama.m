function [pow_gama,w]=power_of_gama(x)
[C,L] = wavedec(x,5,'db1');                 
gama = wrcoef('d',C,L,'db1',2);          %GAMMA
[pow_gama,w] = periodogram(gama);
end