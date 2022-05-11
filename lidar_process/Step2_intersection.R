library(rgdal)
library(raster)
library(ggplot2)

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2007/")

# read in lidar metrics

filelist=list.files(pattern = "*.tif")
lidar_metrics=stack(filelist)

# read in the plot database

plot_db=readOGR(dsn="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/field/data_dhm2007_richness_gr_shp.shp")
plot_db_sel=plot_db@data[is.na(plot_db@data$HabGroup)==FALSE,]

# intersect

metrics <- extract(lidar_metrics,plot_db_sel)
plt_db_wlidar=cbind(plot_db_sel@data,metrics)
write.csv(plt_db_wlidar,"plt_dbt_wlidar_dhm2007.csv")