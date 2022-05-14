library(randomForest)
library(caret)
library(e1071)

library(raster)
library(stringr)

### read fitted models in 2015

natdry_2015=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natdry_2015_cv100.rds")
natwet_2015=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natwet_2015_cv100.rds")
forest_2015=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natforest_2015_cv100.rds")

# read rasters with appropriate mask in

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/masked/")

natdry_list=list.files(pattern="*_natdrymask.tif")
natwet_list=list.files(pattern="*_natwetmask.tif")
forest_list=list.files(pattern="*_forestmask.tif")

dhm2015_metrics_natdry=stack(natdry_list)
dhm2015_metrics_natwet=stack(natwet_list)
dhm2015_metrics_forest=stack(forest_list)

# make renaming of coloumns

newnames=substr(names(dhm2015_metrics_natdry),1,nchar(names(dhm2015_metrics_natdry))-11)
names(dhm2015_metrics_natdry)<-newnames
names(dhm2015_metrics_natwet)<-newnames
names(dhm2015_metrics_forest)<-newnames

# prediction

Pred_natdry_2015 <- predict(dhm2015_metrics_natdry, model=natdry_2015, na.rm=TRUE)
writeRaster(Pred_natdry_2015, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_natdry_2015.tif", format="GTiff",overwrite=TRUE)

Pred_natwet_2015 <- predict(dhm2015_metrics_natwet, model=natwet_2015, na.rm=TRUE)
writeRaster(Pred_natwet_2015, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_natwet_2015.tif", format="GTiff",overwrite=TRUE)

Pred_forest_2015 <- predict(dhm2015_metrics_forest, model=forest_2015, na.rm=TRUE)
writeRaster(Pred_forest_2015, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_forest_2015.tif", format="GTiff",overwrite=TRUE)

### read fitted models in 2007

natdry_2007=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natdry_2007_cv100.rds")
natwet_2007=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natwet_2007_cv100.rds")
forest_2007=readRDS("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/rf_natforest_2007_cv100.rds")

# read rasters with appropriate mask in

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2007/masked/")

natdry_list=list.files(pattern="*_natdrymask.tif")
natwet_list=list.files(pattern="*_natwetmask.tif")
forest_list=list.files(pattern="*_forestmask.tif")

dhm2007_metrics_natdry=stack(natdry_list)
dhm2007_metrics_natwet=stack(natwet_list)
dhm2007_metrics_forest=stack(forest_list)

# make renaming of coloumns

newnames=substr(names(dhm2007_metrics_natdry),1,nchar(names(dhm2007_metrics_natdry))-11)
names(dhm2007_metrics_natdry)<-newnames
names(dhm2007_metrics_natwet)<-newnames
names(dhm2007_metrics_forest)<-newnames

# prediction

Pred_natdry_2007 <- predict(dhm2007_metrics_natdry, model=natdry_2007, na.rm=TRUE)
writeRaster(Pred_natdry_2007, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_natdry_2007.tif", format="GTiff",overwrite=TRUE)

Pred_natwet_2007 <- predict(dhm2007_metrics_natwet, model=natwet_2007, na.rm=TRUE)
writeRaster(Pred_natwet_2007, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_natwet_2007.tif", format="GTiff",overwrite=TRUE)

Pred_forest_2007 <- predict(dhm2007_metrics_forest, model=forest_2007, na.rm=TRUE)
writeRaster(Pred_forest_2007, filename="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/lidar/Pred_forest_2007.tif", format="GTiff",overwrite=TRUE)

