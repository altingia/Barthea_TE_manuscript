#!/usr/bin/python
#coding:utf8
import sys
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import datetime
import time
import numpy as np
from pandas import Series, DataFrame

df = pd.read_excel(r"Helitron_downstream.xls")

distances = list(df.Distance)
#bins=[1, 2000,4000,6000,8000,10000,15000,20000,np.inf]
#labels = ["<2K",">=2K<4K",">=4K<6K",">=6K<8K",">=8K<10K",">=10K<15K",">=15K<20K",">=20K"]
bins=[1, 500,1000,2000,np.inf]
labels = ["1-0.5kbp","0.5-1kbp","1-2kbp","2kbp+"]



groups = pd.cut(distances, bins =bins, labels = labels)
data = groups.value_counts()
df1 = DataFrame(data,columns=["Distance"])
plt.subplot(1,1,1)
x=labels
y=df1["Distance"].values
plt.bar(x,y,width=0.5,align="center")
for a,b in zip(x,y):
	plt.text(a,b,b,ha="center",va="bottom",fontsize=12)
plt.xlabel('category',labelpad=10)
plt.ylabel('Counts')
plt.savefig(r"Helitrons_downstream.jpg")

