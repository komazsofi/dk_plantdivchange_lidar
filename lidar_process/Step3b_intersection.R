library(rgdal)
library(raster)
library(ggplot2)

# read in the plot database

plot_db=readOGR(dsn="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/corresponded_training.shp")
plot_db_sel=plot_db[is.na(plot_db@data$HbGrp_x)==FALSE,]
plot_db_sel=plot_db[is.na(plot_db@data$HbGrp_y)==FALSE,]

## 2007

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2007/")

# read in lidar metrics

filelist=list.files(pattern = "*.tif")
lidar_metrics=stack(filelist)

# intersect

metrics <- extract(lidar_metrics,plot_db_sel)
plt_db_wlidar=cbind(plot_db_sel@data,metrics)

## 2015

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/")

# read in lidar metrics

filelist_2=list.files(pattern = "*.tif")
lidar_metrics_2015=stack(filelist_2)

# intersect

metrics_2015 <- extract(lidar_metrics_2015,plot_db_sel)
plt_db_wlidar_both=cbind(plt_db_wlidar,metrics_2015)
write.csv(plt_db_wlidar_both,"O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_both.csv")