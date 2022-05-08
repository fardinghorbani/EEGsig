

***Tutorial for Working with EEGsig***

**How to use EEGsig for pre-processing and**

**feature extraction?**

\- **First run the EEG.mat file with MATLAB software**

*Figure 1* .*After running EEG.mat, the software is run and we see the following image*





\-

**Now in this step we have to load the desired data in EEGsig**

*Figure 2* .*To load the data, press the button marked with a red arrow*

*Figure 3* .*Then we load the desired data from the data folder*





*Figure 4* . *Our data is then displayed automatically*

\-

**Then it is time to enter the sampling frequency**

It is important to note that since the frequency range of the EEG signal is between

0.5 and 60 Hz, in order to comply with the Nyquist principle, the data sampling

frequency must be more than 2 times 60 Hz, i.e. more than 120 Hz.

*Figure 5* .*After entering the data in the desired location, press the Enter key*





\- **Next step is denoise and artifact removal**

*Figure 6* . *Now we have to select the denoise and artifact removal by selecting it in the red box on the*

*left and then select the desired channel to view each channel in a larger size.*

\-

**Then it is time to enter the sampling frequency**

*Figure 7* . *Select the desired feature to extract the data and display it*





**How to use EEGsig classification?**

\-

**First, we have to load the feature data and its corresponding label in the**

**software**

*Figure 8* . *First, we load the feature data by pressing the button marked with a red arrow*

*Figure 9* . *Then, by pressing the button marked with a red arrow, we load the labels*





\-

**Now we select one of the available algorithms and enter the desired**

**parameters**

*Figure 10* .*Here we select the neural network and enter the number of hidden layer neurons and the*

*percentage of training data and then we hit the run button*.

\- **Now we can see the results**





