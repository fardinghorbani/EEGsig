function out=filetring_1to60eeg(sig,fs)
% this is function to create 0.5 to 60 Hz filtering eeg data

[b,c]=butter(2,[0.5 60]/(fs/2));
out = filter( b,c, sig );

 

end