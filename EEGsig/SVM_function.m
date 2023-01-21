function [  acc_tr,acc_ts,se_tr,se_ts,sp_tr,sp_ts ] = SVM_function( clasification_data , label_data , ttp )

    %%%%%----> select data
          % train percent

    %%%%%%%----> train and test

    x = clasification_data;
    t = label_data;
    N = numel(t);
    PR = randperm(N);
    t = t(PR);
    x = x(PR,:);
    pTrain = ttp/100;
    Ix1 = find(t==1)';
    Ix2 = find(t==0)';
    TrainInd1 = Ix1(1:round(pTrain*numel(Ix1)));
    TrainInd2 = Ix2(1:round(pTrain*numel(Ix2)));
    TrainInd = [TrainInd1 TrainInd2];
    TestInd1 = Ix1(round(pTrain*numel(Ix1))+1:end);
    TestInd2 = Ix2(round(pTrain*numel(Ix2))+1:end);
    TestInd = [TestInd1 TestInd2];

    %%%%%%----> svm 

    SVMStruct = svmtrain(x(TrainInd,:),t(TrainInd),'kernel_function','rbf');
    Y_tr = svmclassify(SVMStruct,x(TrainInd,:));
    Y_ts = svmclassify(SVMStruct,x(TestInd,:));

    %%%%%%----> Error and accuracy and sensitivity and specificity

    [Err_tr, CM_tr] = confusion(t(TrainInd)',Y_tr');
    [Err_ts, CM_ts] = confusion(t(TestInd)',Y_ts');

    acc_tr = (1-Err_tr)*100;
    acc_ts = (1-Err_ts)*100;

    se_tr = CM_tr(2,2)/sum(CM_tr(2,:))*100;
    se_ts = CM_ts(2,2)/sum(CM_ts(2,:))*100;

    sp_tr = CM_tr(1,1)/sum(CM_tr(1,:))*100;
    sp_ts = CM_ts(1,1)/sum(CM_ts(1,:))*100;

end

%%
