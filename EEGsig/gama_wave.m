function [gama]=gama_wave(x)
[C,L] = wavedec(x,5,'db1');
cD2 = detcoef(C,L,2);                   %GAMMA                   
gama = wrcoef('d',C,L,'db1',2);          %GAMMA
end