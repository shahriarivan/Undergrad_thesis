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
% featureSet = featureSet(:,randfea(1:100));

%% Random Shuffle

rand_num = randperm(no_samples);
 
X_train = featureSet(rand_num(1:round(0.8*length(rand_num))),:);
Y_train = labelSet(rand_num(1:round(0.8*length(rand_num))),:);

X_test = featureSet(rand_num(round(0.8*length(rand_num))+1:end),:);
Y_test = labelSet(rand_num(round(0.8*length(rand_num))+1:end),:);

%% Partition Train Set

result = multisvm(X_train,Y_train,X_test);

 

%% Testing
test_accuracy_for_iter = sum((result == Y_test))/length(Y_test)*100
  