#!/usr/bin/python env
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
 
df = pd.read_table("./bar_te_sorted.csv",sep="\t")
plt.figure(figsize=(12,8), dpi= 80)
plt.rcParams["axes.labelsize"] = 15
plt.xlabel('Age (Myr)')
plt.xlim(0, 12)
plt.tick_params(axis='both', labelsize=14)
sns.kdeplot(df.loc[df['superfamily'] == "RLG", "age"], shade=True, color="red", label="Gypsy", alpha=.6)
sns.kdeplot(df.loc[df['superfamily'] == "RLC", "age"], shade=True, color="dodgerblue", label="Copia", alpha=.6)
sns.kdeplot(df.loc[df['superfamily'] == "RLX", "age"], shade=True, color="orange", label="LTR_unknown", alpha=.6)
sns.kdeplot(df.loc[df['superfamily'] == "TIR", "age"], shade=True, color="yellow", label="TIRs", alpha=.6)
plt.title('Density plot of transposable elements age for B.barthei', fontsize=15)
plt.legend(fontsize=15)
#plt.show()
plt.savefig("./TE_age1.svg",dpi=300)
