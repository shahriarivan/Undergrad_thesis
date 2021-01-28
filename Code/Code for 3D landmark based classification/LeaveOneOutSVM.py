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
with open('features2.csv') as file:
    reader = csv.reader(file,delimiter = ',')
    for row in reader:
        rows = [];    
        for ele in row:
            rows.append(float(ele));
        features.append(rows)

labels = []
with open('labels2.csv') as file:
    reader = csv.reader(file,delimiter = ',')
    for row in reader:
        for ele in row:
            labels.append(int(ele))

X = np.array(features)
y = np.array(labels)

from sklearn.model_selection import KFold
from sklearn.svm import SVC 
import time
kf = KFold(n_splits = 537,random_state = 0,shuffle = False)
kf.get_n_splits(X);

id = 0
count = 0

predicted = [];
actual = [];
for train_index, test_index in kf.split(X):
    X_train, X_test = X[train_index], X[test_index]
    y_train, y_test = y[train_index], y[test_index]

    svm_model_linear = SVC(kernel = 'linear',C = 1).fit(X_train, y_train) 
    svm_predictions = svm_model_linear.predict(X_test)    
    accuracy = svm_model_linear.score(X_test, y_test) 
    actual.append(y_test[0])
    predicted.append(svm_predictions[0])
    
    id = id + 1
    if accuracy == 0:
        print("id: " + str(id))    
        print(svm_predictions)
    count = count + accuracy
    

from sklearn.metrics import confusion_matrix 
from sklearn.metrics import accuracy_score 
from sklearn.metrics import classification_report 

results = confusion_matrix(actual, predicted) 
print('Confusion Matrix')
print(results)
print ('Accuracy Score :',accuracy_score(actual, predicted))
print ('Report : ')
print (classification_report(actual, predicted))