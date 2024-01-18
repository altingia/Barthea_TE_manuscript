#!/usr/bin/python
#coding:utf8
import matplotlib

import matplotlib.pyplot as plt

import numpy as np

plt.figure(figsize=(13, 4))

# 构造x轴刻度标签、数据

labels = ['1-0.5kbp', '0.5-1kbp', '1-2kbp', '2kbp+']

upstream = [747, 687, 936, 2027]

downstream = [397, 386, 500, 1797]


# 两组数据

plt.subplot(1,1,1)

x = np.arange(len(labels)) # x轴刻度标签位置

width = 0.45 # 柱子的宽度

# 计算每个柱子在x轴上的位置，保证x轴刻度标签居中

# x - width/2，x + width/2即每组数据在x轴上的位置

plt.bar(x - width/2, upstream, width, label='Upstream')

plt.bar(x + width/2, downstream, width, label='Downstream')

plt.ylabel('Number of DNA/Helitron with the nearest adjacent gene')

plt.xlabel('Distance to the nearest gene',labelpad=5)

# x轴刻度标签位置不进行计算

plt.xticks(x, labels=labels)
plt.legend()
plt.show()
#plt.savefig(r"bar4.jpg")
