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


# dividing X, y into train and test data 

# training a linear SVM classifier 
from sklearn.svm import SVC 
from sklearn.model_selection import cross_val_score

clf = SVC(kernel = 'linear',C = 1)

scores = cross_val_score(clf,X,y,cv = 11)

print(scores)
print(scores.mean() * 100) 