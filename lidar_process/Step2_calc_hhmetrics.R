library(raster)
library(snow)

# 2007

workingdirectory="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2007/"
setwd(workingdirectory)

height_2007=raster("vegetation_height_dhm2007.tif")
vegdens_2007=raster("vegetation_density_dhm2007.tif")

# horizontal metrics

height_class_shrub_2007=reclassify(height_2007, c(c(-Inf,1,0,1,3,1,3,5,0,5,Inf,0)))

beginCluster(20)

sd_dsm_2007=clusterR(height_2007, focal, args=list(w=matrix(1,9,9), fun=sd, pad=TRUE,na.rm = TRUE))
sd_pdens_2007=clusterR(vegdens_2007, focal, args=list(w=matrix(1,9,9), fun=sd, pad=TRUE,na.rm = TRUE))
prop_shrubveg_2007=clusterR(height_class_shrub_2007, focal, args=list(w=matrix(1,9,9), fun=sum, pad=TRUE,na.rm = TRUE))

endCluster()

# export

writeRaster(sd_dsm_2007,"sd_dsm_2007.tif",overwrite=TRUE)
writeRaster(sd_pdens_2007,"sd_pdens_2007.tif",overwrite=TRUE)
writeRaster(prop_shrubveg_2007,"prop_shrubveg_2007.tif",overwrite=TRUE)

# 2015

workingdirectory="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/"
setwd(workingdirectory)

height_2015=raster("canopy_height.tif")
vegdens_2015=raster("vegetation_density.tif")

# horizontal metrics

height_class_shrub_2015=reclassify(height_2015, c(c(-Inf,1,0,1,3,1,3,5,0,5,Inf,0)))

beginCluster(20)

sd_dsm_2015=clusterR(height_2015, focal, args=list(w=matrix(1,9,9), fun=sd, pad=TRUE,na.rm = TRUE))
sd_pdens_2015=clusterR(vegdens_2015, focal, args=list(w=matrix(1,9,9), fun=sd, pad=TRUE,na.rm = TRUE))
prop_shrubveg_2015=clusterR(height_class_shrub_2015, focal, args=list(w=matrix(1,9,9), fun=sum, pad=TRUE,na.rm = TRUE))

endCluster()

# export

writeRaster(sd_dsm_2015,"sd_dsm_2015.tif",overwrite=TRUE)
writeRaster(sd_pdens_2015,"sd_pdens_2015.tif",overwrite=TRUE)
writeRaster(prop_shrubveg_2015,"prop_shrubveg_2015.tif",overwrite=TRUE)