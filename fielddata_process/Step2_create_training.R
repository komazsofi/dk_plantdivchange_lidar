library(data.table)
library(tidyverse)

library(raster)

source("C:/_Koma/GitHub/komazsofi/dk_plantdivchange_lidar/fielddata_process/Functions_forprocess.R")

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/field/")
data<-as.data.frame(fread("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/field/NOVANAAndP3_tozsofia/NOVANAAndP3_tozsofia.tsv",encoding="UTF-8"))

# 2006/2007

data_dhm2007=data[(data$Yeare==2006 | data$Yeare==2007),]

data_dhm2007_richness=data_dhm2007 %>% 
  group_by(Plot5mID,Yeare,Habitat,HabitatID,UTM_X_orig,UTM_Y_orig) %>%
  summarize(SpRichness=n())

data_dhm2007_richness_gr=habitatgrouping(data_dhm2007_richness)

data_dhm2007_richness_gr_shp=convert_to_shp(data_dhm2007_richness_gr)
raster::shapefile(data_dhm2007_richness_gr_shp,"data_dhm2007_richness_gr_shp",overwrite=TRUE)

# 2014/2015

data_dhm2015=data[(data$Yeare==2014 | data$Yeare==2015),]

data_dhm2015_richness=data_dhm2015 %>% 
  group_by(Plot5mID,Yeare,Habitat,HabitatID,UTM_X_orig,UTM_Y_orig) %>%
  summarize(SpRichness=n())

data_dhm2015_richness_gr=habitatgrouping(data_dhm2015_richness)

data_dhm2015_richness_gr_shp=convert_to_shp(data_dhm2015_richness_gr)
raster::shapefile(data_dhm2015_richness_gr_shp,"data_dhm2015_richness_gr_shp",overwrite=TRUE)