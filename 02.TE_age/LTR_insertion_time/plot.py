#!/usr/bin/python env
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
 
df = pd.read_table("./LTRs_age.txt",sep="\t")
plt.figure(figsize=(12,8), dpi= 80)
plt.rcParams["axes.labelsize"] = 15
plt.xlabel('Insertion Time (MYA)')
plt.xlim(0, 1.50)
plt.tick_params(axis='both', labelsize=14)
sns.kdeplot(df.loc[df['superfamily'] == "Copia", "age"], shade=True, color="red", label="LTR/Gypsy", alpha=.5)
sns.kdeplot(df.loc[df['superfamily'] == "Gypsy", "age"], shade=True, color="dodgerblue", label="LTR/Copia", alpha=.5)
sns.kdeplot(df.loc[df['superfamily'] == "Unknown", "age"], shade=True, color="orange", label="LTR/unknown", alpha=.5)
#sns.kdeplot(df.loc[df['superfamily'] == "TIR", "age"], shade=True, color="yellow", label="TIRs", alpha=.4)
#plt.title('Density plot of LTR transposable elements insertion time for B.barthei', fontsize=15)
plt.legend(fontsize=20)
#plt.show()
plt.savefig("./TE_age.svg",dpi=300)
