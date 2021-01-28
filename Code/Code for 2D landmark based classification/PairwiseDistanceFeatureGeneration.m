clear;

info = dir('*/*.csv');

featureSet = [];
labelSet = [];
for i = 1 : length(info)
    file = extractBetween(info(i).name,1,length(info(i).name) - 4);
    label = extractBetween(file,'','_');
    filelocation = strcat(label,'/',file,'.csv');
    
    data = csvread(char(filelocation));
    row = allpairXY(data);
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
index = [67, 133, 145, 190, 198, 199, 262, 448, 508, 567, 591, 625, 627, 682, 847, 925, 952, 953, 1003, 1053, 1071, 1075, 1102, 1150, 1166, 1168, 1169, 1214, 1215, 1288, 1291, 1332, 2014, 2093, 2253, 2351, 2869, 3435, 3471, 3551, 3556, 3558, 3565, 3594, 3775, 3811, 3876, 4007, 4319, 4463];
for i = 1 : length(index)
    index(i) = index(i) + 1;
end
fix = [index];
fix = unique(fix);
take = featureSet(:,fix);

csvwrite('onlyncafeatures2d.csv',take);
csvwrite('onlyncalabels2d.csv',labelSet);

