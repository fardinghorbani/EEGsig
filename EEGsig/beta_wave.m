function [beta]=beta_wave(x)
[C,L] = wavedec(x,5,'db1');
cD3 = detcoef(C,L,3);                  %BETA
beta  = wrcoef('d',C,L,'db1',3);          %BETA
end