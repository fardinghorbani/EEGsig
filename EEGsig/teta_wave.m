function [teta]=teta_wave(x)
[C,L] = wavedec(x,5,'db1');
cD5 = detcoef(C,L,5);                   %THETA
teta = wrcoef('d',C,L,'db1',5);          %THETA
end