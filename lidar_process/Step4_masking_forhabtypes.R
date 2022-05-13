library(terra)
library(stringr)

workingdirectory="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2015/"
setwd(workingdirectory)

# Import

forest=rast("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/Basemap03_public_geotiff/Forest_2018.tif")
naturedry=rast("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/Basemap03_public_geotiff/Nature dry.tif")
naturewet=rast("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/Basemap03_public_geotiff/Nature wet.tif")

filelist=list.files(pattern = "*.tif")

# adjust extents

metrics=rast(filelist)

e <- ext(metrics)
forest_crop <- crop(forest, e)
naturedry_crop <- crop(naturedry, e)
naturewet_crop <- crop(naturewet, e)

metrics_crop=crop(metrics, ext(forest_crop))

# masking one by one

for (i in 1:length(filelist)) {
  print(i)
  
  mask(metrics_crop[[i]], forest_crop, maskvalues=0, updatevalue=NA, filename=paste0(workingdirectory,"/","masked","/",str_sub(filelist[i],1,nchar(filelist[i])-4),"_forestmask.tif"))
  mask(metrics_crop[[i]], naturedry_crop, maskvalues=0, updatevalue=NA, filename=paste0(workingdirectory,"/","masked","/",str_sub(filelist[i],1,nchar(filelist[i])-4),"_natdrymask.tif"))
  mask(metrics_crop[[i]], naturewet_crop, maskvalues=0, updatevalue=NA, filename=paste0(workingdirectory,"/","masked","/",str_sub(filelist[i],1,nchar(filelist[i])-4),"_natwetmask.tif"))
  
}