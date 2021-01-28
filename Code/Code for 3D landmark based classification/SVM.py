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
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state = 5) 

print(X_train.shape)
print(X_test.shape)

# training a linear SVM classifier 
from sklearn.svm import SVC 
svm_model_linear = SVC(kernel = 'linear', C = 1).fit(X_train, y_train) 
svm_predictions = svm_model_linear.predict(X_test) 
  
# model accuracy for X_test   
accuracy = svm_model_linear.score(X_test, y_test) 
  
# creating a confusion matrix 
cm = confusion_matrix(y_test, svm_predictions) 

print(accuracy);