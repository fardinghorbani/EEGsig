function [ Acc_tr,Acc_ts,sen_tr,sen_ts,spe_tr,spe_ts ] = NN_function( data, label , nofn , ttp)
% input   : data and label and number of hiddenLayerSize and train and test percent
% output  : sensitivity and accuracy and specificity
% we choose %10 of data for validation
x = data';
t = label';
trainFcn = 'trainlm';  
% Create a Pattern Recognition Network
hiddenLayerSize = nofn;
net = patternnet(hiddenLayerSize);
% Choose Input and Output Pre/Post-Processing Functions
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
% Setup Division of Data for Training, Validation, Testing
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = ttp/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = (ttp-10)/100;
% Choose a Performance Function
net.performFcn = 'mse';  
% Choose Plot Functions
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotconfusion', 'plotroc'};

net.layers{end}.transferFcn='purelin';
net.trainParam.max_fail=10

% Train the Network
[net,tr] = train(net,x,t);
% Test the Network
y = net(x);
[Err_tr,CM_tr]=confusion(t([tr.trainInd tr.valInd]),y([tr.trainInd tr.valInd]));
[Err_ts,CM_ts]=confusion(t(tr.testInd),y(tr.testInd));

%accuracy
Acc_tr=(1-Err_tr)*100;
Acc_ts=(1-Err_ts)*100;
%sensitivity
sen_tr=CM_tr(2,2)/sum(CM_tr(2,:))*100;
sen_ts=CM_ts(2,2)/sum(CM_ts(2,:))*100;
%specificity
spe_tr=CM_tr(1,1)/sum(CM_tr(1,:))*100;
spe_ts=CM_ts(1,1)/sum(CM_ts(1,:))*100;


end

