#!/usr/bin/env python
# coding: utf-8

# In[7]:


# import libraries 

from bs4 import BeautifulSoup #parses the unwanted data by fixing bad HTML and present in an easily-traversible XML structures.
import requests#allows you to send HTTP requests using Python. 
import time
import datetime

import smtplib#SMTP client session object that can be used to send mail to any internet-machine with SMTP listener daemon.


# In[ ]:


#Connect to Website.


# In[42]:


URL = 'https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ'

#You can use httpbin to test and inspect the data that would be sent the 3rd party service.
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8","DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

page = requests.get(URL, headers=headers)

Soup1 = BeautifulSoup(page.content, "html.parser")
           
Soup2 = BeautifulSoup(Soup1.prettify(), "html.parser")#better format of code.

title = Soup2.find(id='productTitle').get_text()

#price = Soup2.find(id='corePrice_feature_div').get_text()

print(title)
#print(price)



# In[55]:


title = title.strip()#title came to corner from middle. Helps clean whitespaces.
print(title)


# In[56]:


import datetime
today = datetime.date.today()
print(today)


# In[57]:


import csv

header = ['Title','Date']
data = [title, today]
type(data)#checking the dataype if it's a list, array, etc.

#getting the scrapped data in csv fileformat into your system storage.
with open('AmazonWebScraperDataSet.csv', 'w', newline='', encoding ='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerow(data)


# In[74]:


import pandas as pd

df = pd.read_csv(r'C:\Users\SAMAD\AmazonWebScraperDataSet.csv')
print(df)


# In[78]:


#appending data for csv.
with open('AmazonWebScraperDataSet.csv', 'a+', newline='', encoding ='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(data)      


# In[84]:


def check_title():
    
    URL = "https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ"

    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8","DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

    page = requests.get(URL, headers=headers)

    Soup1 = BeautifulSoup(page.content, "html.parser")
           
    Soup2 = BeautifulSoup(Soup1.prettify(), "html.parser")#better format of code.

    title = Soup2.find(id='productTitle').get_text()
    
    title = title.strip()

    import datetime

    today = datetime.date.today()

    import csv

    header = ['Title','Date']
    data = [title, today]

    with open('AmazonWebScraperDataSet.csv', 'w', newline='', encoding ='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(data)


# In[ ]:


while(True):
    check_title()
    time.sleep(5)


# In[97]:


import pandas as pd

df = pd.read_csv(r'C:\Users\SAMAD\AmazonWebScraperDataSet.csv')

print(df)

