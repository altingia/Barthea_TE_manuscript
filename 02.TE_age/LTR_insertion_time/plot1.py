#!/usr/bin/python env
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
sns.set_style("white")

# Import data
df = pd.read_table("./LTRs_age.txt",sep="\t")
x1 = df.loc[df.superfamily=='Copia', 'age']
x2 = df.loc[df.superfamily=='Gypsy', 'age']
x3 = df.loc[df.superfamily=='Unknown', 'age']

kwargs = dict(alpha=0.3, bins=40)

plt.hist(x1, **kwargs, color='red', label='Copia')
plt.hist(x2, **kwargs, color='yellow', label='Gypsy')
plt.hist(x3, **kwargs, color='blue', label='Unknown')
plt.gca().set(title='Frequency Histogram of intact LTRs insertion time', ylabel='Frequency')
plt.xlim(0.00,1.20)
plt.xlabel('Insertion Time (MYA)')
plt.legend()
plt.savefig("./TE_age.svg",dpi=300)





