%% Intro
clear;

info = dir('*/*.csv');

featureSet = [];
labelSet = [];
for i = 1 : length(info)
    file = extractBetween(info(i).name,1,length(info(i).name) - 4);
    label = extractBetween(file,'','_');
    filelocation = strcat(label,'/',file,'.csv');
    
    data = csvread(char(filelocation));
    row = allpairXYZ(data);
    featureSet = [featureSet;row];
    labelSet = [labelSet;string(label)];
    
end

labelSet = grp2idx(labelSet);


idx = fscnca(featureSet,labelSet,'Solver','sgd','Verbose',1);

%% Modification

sorted = sort(idx.FeatureWeights,'descend');
threshold = sorted(100);
alltype = [];
for i = 1 : length(sorted)
    if idx.FeatureWeights(i) >= threshold
        alltype = [alltype i];
    end
end

%% Not Necesssary
% index = [0, 2, 3, 38, 67, 133, 134, 198, 199, 262, 263, 325, 387, 508, 556, 568, 625, 738, 793, 850, 872, 900, 901, 904, 917, 920, 952, 971, 972, 1021, 1071, 1103, 2121, 2192, 2766, 2775, 2825, 2918, 3501, 3552, 3573, 3821, 3863, 4424, 4952, 5103, 5282, 5337, 5997, 6657];
% for i = 1 : length(index)
%     index(i) = index(i) + 1;
% end

fix = [alltype];
fix = unique(fix);
take = featureSet(:,fix);

csvwrite('onlyncafeatures.csv',take);
csvwrite('onlyncalabels.csv',labelSet);