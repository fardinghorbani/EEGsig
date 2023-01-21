function [delta]=delta_wave(x)
[C,L] = wavedec(x,5,'db1');
cA5 = appcoef(C,L,'db1',5);                 %DELTA                     
delta = wrcoef('a',C,L,'db1',5);          %DELTA
end