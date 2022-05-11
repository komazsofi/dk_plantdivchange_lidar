library(rgdal)
library(raster)
library(ggplot2)

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/")

# Load list of EcoDes-DK15 descriptors
raster_list <- shell("dir /b /s O:\\Nat_Sustain-proj\\_user\\ZsofiaKoma_au700510\\FeasStudy\\processing\\lidar\\dhm2015\\*.vrt",
                     intern = T) 
raster_list <- gsub("\\\\", "/", raster_list)

raster_list_needed=raster_list[c(1,2,4,5,8,9)]

lidar_metrics=stack(raster_list_needed)

lidar_metrics$twi=lidar_metrics$twi/1000
lidar_metrics$vegetation_density=lidar_metrics$vegetation_density/10000
lidar_metrics$slope=lidar_metrics$slope/10
lidar_metrics$normalized_z_sd=lidar_metrics$normalized_z_sd/100
lidar_metrics$canopy_height=lidar_metrics$canopy_height/100

writeRaster(lidar_metrics,filename=names(lidar_metrics),bylayer=TRUE,format="GTiff")