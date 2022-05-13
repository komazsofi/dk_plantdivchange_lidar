library(randomForest)
library(caret)
library(e1071)

library(raster)
library(stringr)

# read fitted models in

natdry_2015=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natdry_2015_cv100.rds")

# read rasters with appropriate mask in

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/masked/")

natdry_list=list.files(pattern="*_natdrymask.tif")

dhm2015_metrics_natdry=stack(natdry_list)

# make renaming of coloumns

newnames=substr(names(dhm2015_metrics_natdry),1,nchar(names(dhm2015_metrics_natdry))-11)
names(dhm2015_metrics_natdry)<-newnames

# prediction

Pred_natdry_2015 <- predict(dhm2015_metrics_natdry, model=natdry_2015, na.rm=TRUE)
writeRaster(Pred_natdry_2015, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_natdry_2015.tif", format="GTiff",overwrite=TRUE)

