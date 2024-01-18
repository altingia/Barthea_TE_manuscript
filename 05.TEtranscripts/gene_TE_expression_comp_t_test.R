setwd("C:\\Users\\wuei0\\Ubuntu\\Transposable_elements\\05.TEtranscripts")
library(ggplot2)        # plotting & data
library(dplyr)          # data manipulation
library(tidyr)          # data re-shaping
library(magrittr)       # pipe operator
library(gridExtra)      # provides side-by-side plotting
exp <- read.table("Barthea_meanBase.txt", header=F)
colnames(exp) <- c("type","meanbase")

df <- exp %>%
  filter(type == "Gene" | type == "TE") %>%
  select(type, meanbase)

summary(df %>% filter(type == "Gene") %>% .$meanbase)
#Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#0.7     36.7    180.7    481.4    510.3 221415.2 

summary(df %>% filter(type == "TE") %>% .$meanbase)
#Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#0.0      1.7      3.5    148.1      8.7 251422.1 

ggplot(df, aes(type, meanbase)) +
  geom_boxplot()

t.test(meanbase ~ type, data = df)