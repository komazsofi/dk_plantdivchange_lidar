library(data.table)
library(tidyverse)

library(raster)

source("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_Berlin/_code/dk_plantdivchange_lidar/fielddata_process/Functions_forprocess.R")

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_Berlin/Results/")

### Input

data<-as.data.frame(fread("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_Berlin/Input_data/Field/NOVANAAndP3_tozsofia/NOVANAAndP3_tozsofia.tsv",encoding="UTF-8"))

## select time

# 2007
data_dhm2007=data[(data$Yeare==2006 | data$Yeare==2007),]
data_dhm2007_sel=data_dhm2007[is.na(data_dhm2007$Plot5mID)==FALSE,]
data_dhm2007_sel2=data_dhm2007_sel[data_dhm2007_sel$Habitat!="Mix",]

data_dhm2007_richness=data_dhm2007_sel2 %>% 
  group_by(Plot5mID,Yeare,Habitat,HabitatID,UTM_X_orig,UTM_Y_orig,AktID,StedID) %>%
  summarize(SpRichness=n())

data_dhm2007_richness_gr=habitatgrouping(data_dhm2007_richness)

data_dhm2007_richness_gr_shp=convert_to_shp(data_dhm2007_richness_gr)

# 2015
data_dhm2015=data[(data$Yeare==2014 | data$Yeare==2015),]
data_dhm2015_sel=data_dhm2015[is.na(data_dhm2015$Plot5mID)==FALSE,]
data_dhm2015_sel2=data_dhm2015_sel[data_dhm2015_sel$Habitat!="Mix",]

data_dhm2015_richness=data_dhm2015_sel2 %>% 
  group_by(Plot5mID,Yeare,Habitat,HabitatID,UTM_X_orig,UTM_Y_orig,AktID,StedID) %>%
  summarize(SpRichness=n())

data_dhm2015_richness_gr=habitatgrouping(data_dhm2015_richness)

data_dhm2015_richness_gr_shp=convert_to_shp(data_dhm2015_richness_gr)

# export

shapefile(data_dhm2007_richness_gr_shp,"O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_Berlin/Results/raw_data_dhm2007.shp",overwrite=TRUE)
shapefile(data_dhm2015_richness_gr_shp,"O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_Berlin/Results/raw_data_dhm2015.shp",overwrite=TRUE)