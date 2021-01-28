clear;

info = dir('*/*.csv');

featureSet = [];
labelSet = [];
for i = 1 : length(info)
    file = extractBetween(info(i).name,1,length(info(i).name) - 4);
    label = extractBetween(file,'','_');

    filelocation = strcat(label,'/',file,'.csv');
    
    data = csvread(char(filelocation));
    
    featureSet = [featureSet;allpairXYZ(data)];
    
    labelSet = [labelSet;string(label)];
end

labelSet = grp2idx(labelSet);

Set = [featureSet labelSet];


