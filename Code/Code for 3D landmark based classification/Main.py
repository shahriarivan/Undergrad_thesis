# -*- coding: utf-8 -*-
"""
Created on Sun Nov 10 15:22:33 2019

@author: fsshakkhor
"""

# importing necessary libraries 

from sklearn import datasets 
from sklearn.metrics import confusion_matrix 
from sklearn.model_selection import train_test_split 

import numpy as np

#iris = datasets.load_iris() 
#  
#
#X = iris.data 
#y = iris.target 


import csv

features = []
with open('features.csv') as file:
    reader = csv.reader(file,delimiter = ',')
    for row in reader:
        rows = [];    
        for ele in row:
            rows.append(float(ele));
        features.append(rows)

labels = []
with open('labels.csv') as file:
    reader = csv.reader(file,delimiter = ',')
    for row in reader:
        for ele in row:
            labels.append(int(ele))

X = np.array(features)
y = np.array(labels)

from sklearn.neighbors import KNeighborsClassifier
from sklearn.datasets import load_iris
from mlxtend.feature_selection import SequentialFeatureSelector as SFS
from sklearn.model_selection import KFold
from sklearn.svm import SVC 
import time

svm_model_linear = SVC(kernel = 'linear', C = 1);

sfs1 = SFS(svm_model_linear,k_features = 10,forward = True,floating = False,verbose = 1,scoring = 'accuracy',cv = 5)

sfs1 = sfs1.fit(X,y);
feat_cols = list(sfs1.k_feature_idx_)
print(feat_cols)

#kf = KFold(n_splits = 537,random_state = 0,shuffle = False)
#kf.get_n_splits(X);


