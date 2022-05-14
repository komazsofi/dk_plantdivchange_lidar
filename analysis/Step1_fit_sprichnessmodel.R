library(randomForest)
library(caret)
library(e1071)

intersected=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/plt_dbt_wlidar_dhm2007.csv")

naturedry=intersected[intersected$HabGroup=="Nature dry",]
naturedry_omit <- na.omit(naturedry) 

naturedry_omit_sel=naturedry_omit[,c(8,10:18)]

naturewet=intersected[intersected$HabGroup=="Nature wet",]
naturewet_omit <- na.omit(naturewet) 

naturewet_omit_sel=naturewet_omit[,c(8,10:18)]

natureforest=intersected[intersected$HabGroup=="Forest",]
natureforest_omit <- na.omit(natureforest) 

natureforest_omit_sel=natureforest_omit[,c(8,10:18)]

# RF
set.seed(1234)

#natdry

trControl <- trainControl(method = "cv",
                          number = 100,
                          search = "grid")

rf_natdry <- train(SpRichness~ .,
                   data = naturedry_omit_sel,
                   method = "rf",
                   trControl = trControl,
                   importance=T)

print(rf_natdry)
varImp(rf_natdry)

#natwet

trControl <- trainControl(method = "cv",
                          number = 100,
                          search = "grid")

rf_natwet <- train(SpRichness ~ .,
                   data = naturewet_omit_sel,
                   method = "rf",
                   trControl = trControl,
                   importance=T)

print(rf_natwet)
varImp(rf_natwet)

#forest

trControl <- trainControl(method = "cv",
                          number = 100,
                          search = "grid")

rf_natforest <- train(SpRichness ~ .,
                      data = natureforest_omit_sel,
                      method = "rf",
                      trControl = trControl,
                      importance=T)

print(rf_natforest)
varImp(rf_natforest)

# export rf objects

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing/")

saveRDS(rf_natdry,"rf_natdry_2007_cv100.rds")
saveRDS(rf_natwet,"rf_natwet_2007_cv100.rds")
saveRDS(rf_natforest,"rf_natforest_2007_cv100.rds")

