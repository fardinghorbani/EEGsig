function [alpha]=alpha_wave(x)
[C,L] = wavedec(x,5,'db1');
cD4 = detcoef(C,L,4);                      %ALPHA
alpha = wrcoef('d',C,L,'db1',4);          %ALPHA
end