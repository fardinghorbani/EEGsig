function [  acc_tr,acc_ts,se_tr,se_ts,sp_tr,sp_ts ] = KNN_function( clasification_data , label_data , ttp )
%this is knn function for classification of data
% input   : clasification_data , label_data
% output  : sensitivity and accuracy and specificity
 x = clasification_data;
 t = label_data;

N = numel(t);
PR = randperm(N);

t = t(PR);
x = x(PR,:);

pTrain = ttp/100;

Ix1 = find(t==0)';
Ix2 = find(t==1)';

TrainInd1 = Ix1(1:round(pTrain*numel(Ix1)));
TrainInd2 = Ix2(1:round(pTrain*numel(Ix2)));
TrainInd = [TrainInd1 TrainInd2];

TestInd1 = Ix1(round(pTrain*numel(Ix1))+1:end);
TestInd2 = Ix2(round(pTrain*numel(Ix2))+1:end);
TestInd = [TestInd1 TestInd2];

knn_mdl=fitcknn(x(TrainInd,:),t(TrainInd));

Y_tr=predict(knn_mdl,x(TrainInd,:));
Y_ts=predict(knn_mdl,x(TestInd,:));

[Err_tr, CM_tr] = confusion(t(TrainInd)',Y_tr');
[Err_ts, CM_ts] = confusion(t(TestInd)',Y_ts');

acc_tr = (1-Err_tr)*100;
acc_ts = (1-Err_ts)*100;

se_tr = CM_tr(2,2)/sum(CM_tr(2,:))*100;
se_ts = CM_ts(2,2)/sum(CM_ts(2,:))*100;

sp_tr = CM_tr(1,1)/sum(CM_tr(1,:))*100;
sp_ts = CM_ts(1,1)/sum(CM_ts(1,:))*100;



end

