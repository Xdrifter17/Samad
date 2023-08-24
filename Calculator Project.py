#!/usr/bin/env python
# coding: utf-8

# In[2]:


#BMI CALCULATOR


# In[1]:


name=input("Enter Your Name: ")

Weight=int(input("Enter Your Weight in Pounds:"))
Height=int(input("Enter Your Height in Inches:"))

BMI= (Weight * 703) / (Height * Height)
print(BMI)

if BMI>0:
    if(BMI<18.5):
        print(name+", You are Under Weight.")
    elif(BMI<=24.9):
        print(name+", You are normal Weight.")
    elif(BMI<29.9):
        print(name+", You are OverWeight. You need to excercise more. Eat Healty!")
    elif(BMI<34.9):
        print(name+", You are obese.")
    elif(BMI<39.9):
        print(name+", You are severly obese.")
    else:
        print(name+", You are morbidly obese.")
else:
        print("Enter valid input:")

