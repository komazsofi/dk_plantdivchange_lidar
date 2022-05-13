library(terra)
library(stringr)

workingdirectory="O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/lidar/dhm2007/"
setwd(workingdirectory)

# Import

forest=rast("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/Basemap03_public_geotiff/Forest_2018.tif")
naturedry=rast("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/Basemap03_public_geotiff/Nature dry.tif")
naturewet=rast("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/data/Basemap03_public_geotiff/Nature wet.tif")

filelist=list.files(pattern = "*.tif")

# adjust extents

onemetric=rast(filelist[1])

e <- ext(onemetric)
forest_crop <- crop(forest, e)
naturedry_crop <- crop(naturedry, e)
naturewet_crop <- crop(naturewet, e)

# masking one by one

for (i in filelist) {
  print(i)
  
  metric=rast(i)
  
  setwd(paste0(workingdirectory,"/","masked","/"))
  
  mask(metric, forest, maskvalues=0, updatevalue=NA, filename=paste0(str_sub(i,1,nchar(i)-4),"_forestmask.tif"))
  mask(metric, naturedry, maskvalues=0, updatevalue=NA, filename=paste0(str_sub(i,1,nchar(i)-4),"_natdrymask.tif"))
  mask(metric, naturewet, maskvalues=0, updatevalue=NA, filename=paste0(str_sub(i,1,nchar(i)-4),"_natwetmask.tif"))
  
}