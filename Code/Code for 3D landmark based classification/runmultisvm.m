%% Preparing DataSet
clear;
info = dir('*/*.csv');

featureSet = [];
labelSet = [];
for i = 1 : length(info) %change 100 to length(info)
    file = extractBetween(info(i).name,1,length(info(i).name) - 4);
    label = extractBetween(file,'','_');

    filelocation = strcat(label,'/',file,'.csv');
    
    data = csvread(char(filelocation));
    
    featureSet = [featureSet;allpairXYZ(data)];
    
    labelSet = [labelSet;string(label)];
end

labelSet = grp2idx(labelSet);

[no_samples no_features] = size(featureSet);

% randfea = randperm(no_features);
% featureSet = featureSet(:,randfea(1:50));

%% Random Shuffle

rand_num = randperm(no_samples);
 
X_train = featureSet(rand_num(1:round(0.8*length(rand_num))),:);
Y_train = labelSet(rand_num(1:round(0.8*length(rand_num))),:);

X_test = featureSet(rand_num(round(0.8*length(rand_num))+1:end),:);
Y_test = labelSet(rand_num(round(0.8*length(rand_num))+1:end),:);

%% Partition Train Set
c = cvpartition(Y_train,'k',5);

%% Sequential Forward Selection

% opts = statset('display','iter');
% classf = @(train_data, train_labels, test_data, test_labels)...
%     sum(multisvm(train_data,train_labels,test_data) ~= test_labels);
% 
% [fs, history] = sequentialfs(classf, X_train, Y_train, 'cv', c, 'options', opts,'nfeatures',5);

%% Best Hyperparameters

% X_train_w_best_feature = X_train(:,fs);

result = multisvm(X_train,Y_train,X_test);
% Md1 = fitcsvm(X_train_w_best_feature,Y_train,'KernelFunction','rbf','OptimizeHyperparameters','auto',...
%       'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%       'expected-improvement-plus','ShowPlots',true)); 

%% Testing
% X_test_w_best_feature = X_test(:,fs);
test_accuracy_for_iter = sum(result == Y_test)/length(Y_test)*100
  