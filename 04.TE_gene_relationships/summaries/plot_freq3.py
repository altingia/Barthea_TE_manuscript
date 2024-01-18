#!/usr/bin/python
#coding:utf8
import matplotlib

import matplotlib.pyplot as plt

import numpy as np

plt.figure(figsize=(13, 4))

# 构造x轴刻度标签、数据

labels = ['0-1.0','1.0-2.0','2.0-3.0','3.0-4.0','4.0-5.0','5.0+']

upstream = [7229,5105,3510,2613,1947,10503]

downstream = [3903,3116,2527,2169,1796,10260]


# 两组数据

plt.subplot(1,1,1)

x = np.arange(len(labels)) # x轴刻度标签位置

width = 0.45 # 柱子的宽度

# 计算每个柱子在x轴上的位置，保证x轴刻度标签居中

# x - width/2，x + width/2即每组数据在x轴上的位置

plt.bar(x - width/2, upstream, width, label='Upstream')

plt.bar(x + width/2, downstream, width, label='Downstream')

plt.ylabel('Number of All TEs with the nearest adjacent gene')

plt.xlabel('Distance to the nearest gene (kbp)',labelpad=5)

# x轴刻度标签位置不进行计算

plt.xticks(x, labels=labels)
plt.legend()
plt.show()
#plt.savefig(r"bar4.jpg")
