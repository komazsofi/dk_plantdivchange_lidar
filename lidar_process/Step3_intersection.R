library(rgdal)
library(raster)
library(ggplot2)

# 2007

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2007/")

# read in lidar metrics

filelist=list.files(pattern = "*.tif")
lidar_metrics=stack(filelist)

# read in the plot database

plot_db=readOGR(dsn="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/field/data_dhm2007_richness_gr_shp.shp")
plot_db_sel=plot_db[is.na(plot_db@data$HabGroup)==FALSE,]

# intersect

metrics <- extract(lidar_metrics,plot_db_sel)
plt_db_wlidar=cbind(plot_db_sel@data,metrics)
write.csv(plt_db_wlidar,"O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/plt_dbt_wlidar_dhm2007.csv")

# 2015

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/")

# read in lidar metrics

filelist_2=list.files(pattern = "*.tif")
lidar_metrics_2015=stack(filelist_2)

# read in the plot database

plot_db_2015=readOGR(dsn="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/field/data_dhm2015_richness_gr_shp.shp")
plot_db_sel_2015=plot_db_2015[is.na(plot_db_2015@data$HabGroup)==FALSE,]

# intersect

metrics_2015 <- extract(lidar_metrics_2015,plot_db_sel_2015)
plt_db_wlidar_2015=cbind(plot_db_sel_2015@data,metrics_2015)
write.csv(plt_db_wlidar_2015,"O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/plt_dbt_wlidar_dhm2015.csv")