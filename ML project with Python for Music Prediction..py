#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
music_data


# In[ ]:


#Seprating dataset into 2 parts so that we can get a predictions from the machine when asked. 


# In[3]:


import pandas as pd
music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
X


# In[4]:


music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
y = music_data['genre']
y


# In[ ]:


#traning data for making predictions.


# In[6]:


import pandas as pd
from sklearn.tree import DecisionTreeClassifier
music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
y = music_data['genre']

model = DecisionTreeClassifier()
model.fit(X,y)
music_data


# In[ ]:


#Passing inputs to machice so that they can make predictions.


# In[23]:


import pandas as pd
from sklearn.tree import DecisionTreeClassifier
music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
y = music_data['genre']

model = DecisionTreeClassifier()
X = X.values #conversion of X into array.
model.fit(X, y)
predictions = model.predict([ [21, 1], [22, 0] ])
predictions


# In[ ]:


#Measuring accuracy of the model.


# In[31]:


import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
y = music_data['genre']
X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2)

model = DecisionTreeClassifier()
X = X.values #conversion of X into array.
model.fit(X_train, y_train)
predictions = model.predict(X_test)

score = accuracy_score(y_test, predictions)
score


# In[ ]:


# Storing a trained model in a file


# In[33]:


import pandas as pd
from sklearn.tree import DecisionTreeClassifier
import joblib

music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
y = music_data['genre']

model = DecisionTreeClassifier()
X = X.values #conversion of X into array.
model.fit(X, y)

joblib.dump(model, 'music-recommender.joblib')


# In[ ]:


#checking model predicting behaviour.


# In[2]:


import pandas as pd
from sklearn.tree import DecisionTreeClassifier
import joblib

# music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
# X = music_data.drop(columns=['genre'])
# y = music_data['genre']

# model = DecisionTreeClassifier()
# X = X.values #conversion of X into array.
# model.fit(X, y)

model = joblib.load('music-recommender.joblib')
predictions = model.predict([[21, 1]])
predictions


# In[ ]:


#Visualizing a decision tree.


# In[ ]:


import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn import tree

music_data = pd.read_csv(r'C:\Users\SAMAD\Downloads\Datasets\music.csv') 
X = music_data.drop(columns=['genre'])
y = music_data['genre']

model = DecisionTreeClassifier()
X = X.values #conversion of X into array.
model.fit(X, y)

tree.export_graphviz(model, out_file='music-recommender.dot',
                    feature_names=['age', 'gender'],
                    class_name=sorted(y.unique()),
                    label='all', #names of parameter.
                    rounded=True, #shape.
                    filled=True) #borders.


# In[ ]:




