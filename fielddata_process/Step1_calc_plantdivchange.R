library(data.table)
library(tidyverse)

library(sf)
library(sp)

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/field/")
data<-as.data.frame(fread("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/field/NOVANAAndP3_tozsofia/NOVANAAndP3_tozsofia.tsv",encoding="UTF-8"))

# calculate species richness per plot per year

data_plot=data %>% 
  group_by(Plot5mID,Yeare,Habitat,HabitatID,UTM_X_orig,UTM_Y_orig) %>%
  summarize(SpRichness=n())

Nof_plot_sampling <- data_plot %>% 
  group_by(Plot5mID) %>% 
  summarise(n = n()) %>% 
  arrange(n) 

TestIDs <- Nof_plot_sampling %>% dplyr::filter(n >= 2) %>% pull(Plot5mID)

For_Analysis <- data_plot %>% 
  dplyr::filter(Plot5mID %in% TestIDs)

For_Analysis_c=For_Analysis[complete.cases(For_Analysis),]

write.csv(For_Analysis_c,"Repeated_5mplotmeasure.csv")

