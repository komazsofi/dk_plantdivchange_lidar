library(data.table)
library(tidyverse)

library(raster)

source("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/__code/dk_plantdivchange_lidar/fielddata_process/Functions_forprocess.R")

### Input

data<-as.data.frame(fread("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/field/NOVANAAndP3_tozsofia/NOVANAAndP3_tozsofia.tsv",encoding="UTF-8"))

## reorganize data

data_dhm_sel=data[(data$Yeare==2005 | data$Yeare==2006 | data$Yeare==2007 | data$Yeare==2008 | data$Yeare==2013 | data$Yeare==2014 | data$Yeare==2015 | data$Yeare==2016),]

data_dhm_richness=data_dhm_sel %>% 
  group_by(Plot15mID,Yeare,Habitat,HabitatID,UTM_X_orig,UTM_Y_orig) %>%
  summarize(SpRichness=n())

data_dhm_richness_gr=habitatgrouping(data_dhm_richness)
data_dhm_richness_gr_forest=data_dhm_richness_gr[data_dhm_richness_gr$HabGroup=="Forest",]
data_dhm_richness_gr_forest$coordID <- paste(data_dhm_richness_gr_forest$UTM_X_orig, "-", data_dhm_richness_gr_forest$UTM_Y_orig)

data_dhm_richness_gr_mon=data_dhm_richness_gr_forest %>% 
  group_by(coordID) %>%
  summarize(nofpl=n())

data_dhm_richness_gr_enh=merge(data_dhm_richness_gr_forest, data_dhm_richness_gr_mon, by = "coordID")
data_dhm_richness_gr_enh=data_dhm_richness_gr_enh[data_dhm_richness_gr_enh$nofpl>1,]

# separate into two years if it was measured more than once

data_dhm_richness_gr_enh_2007=data_dhm_richness_gr_enh[(data_dhm_richness_gr_enh$Yeare==2005 | data_dhm_richness_gr_enh$Yeare==2006 | data_dhm_richness_gr_enh$Yeare==2007 | data_dhm_richness_gr_enh$Yeare==2008),]
data_dhm_richness_gr_enh_2007_nodupl = data_dhm_richness_gr_enh_2007[!duplicated(data_dhm_richness_gr_enh_2007$coordID),]

data_dhm_richness_gr_enh_2015=data_dhm_richness_gr_enh[(data_dhm_richness_gr_enh$Yeare==2013 | data_dhm_richness_gr_enh$Yeare==2014 | data_dhm_richness_gr_enh$Yeare==2015 | data_dhm_richness_gr_enh$Yeare==2016),]
data_dhm_richness_gr_enh_2015_nodupl = data_dhm_richness_gr_enh_2015[!duplicated(data_dhm_richness_gr_enh_2015$coordID),]

data_fortraining=merge(data_dhm_richness_gr_enh_2015_nodupl,data_dhm_richness_gr_enh_2007_nodupl,by="coordID")

# statistics

nofsampleperaggrhabitat=data_fortraining %>% 
  group_by(HabGroup.x) %>%
  summarize(nofn_peraggrhab=n())

# export

data_fortraining_omit <- na.omit(data_fortraining) 
data_fortraining_shp=convert_to_shp(data_fortraining_omit)

shapefile(data_fortraining_shp,"O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/corresponded_training_15mforest.shp",overwrite=TRUE)