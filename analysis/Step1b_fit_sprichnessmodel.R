library(randomForest)
library(caret)
library(e1071)

intersected=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_both.csv")

naturedry=intersected[intersected$HbGrp_x=="Nature dry",]
naturedry_omit <- na.omit(naturedry) 

naturedry_omit_sel_2007=naturedry_omit[,c(9,21:29)]
naturedry_omit_sel_2015=naturedry_omit[,c(18,30:38)]

naturewet=intersected[intersected$HbGrp_x=="Nature wet",]
naturewet_omit <- na.omit(naturewet) 

naturewet_omit_sel_2007=naturewet_omit[,c(9,21:29)]
naturewet_omit_sel_2015=naturewet_omit[,c(18,30:38)]

natureforest=intersected[intersected$HbGrp_x=="Forest",]
natureforest_omit <- na.omit(natureforest) 

natureforest_omit_sel_2007=natureforest_omit[,c(9,21:29)]
natureforest_omit_sel_2015=natureforest_omit[,c(18,30:38)]

# RF
set.seed(1234)

trControl <- trainControl(method = "cv",
                          number = 100,
                          search = "grid",
                          p=75)

#natdry

rf_natdry_2007 <- train(SpRchnss_x~ .,
                   data = naturedry_omit_sel_2007,
                   method = "rf",
                   trControl = trControl,
                   importance=T)

print(rf_natdry_2007)
varImp(rf_natdry_2007)

rf_natdry_2015 <- train(SpRchnss_y~ .,
                        data = naturedry_omit_sel_2015,
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natdry_2015)
varImp(rf_natdry_2015)

#natwet

rf_natwet_2007 <- train(SpRchnss_x~ .,
                        data = naturewet_omit_sel_2007,
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natwet_2007)
varImp(rf_natwet_2007)

rf_natwet_2015 <- train(SpRchnss_y~ .,
                        data = naturewet_omit_sel_2015,
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natwet_2015)
varImp(rf_natwet_2015)

#forest

rf_natforest_2007 <- train(SpRchnss_x~ .,
                        data = natureforest_omit_sel_2007,
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natforest_2007)
varImp(rf_natforest_2007)

rf_natforest_2015 <- train(SpRchnss_y~ .,
                        data = natureforest_omit_sel_2015,
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natforest_2015)
varImp(rf_natforest_2015)

# export rf objects

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/")

saveRDS(rf_natdry_2007,"rf_natdry_2007_cv100.rds")
saveRDS(rf_natwet_2007,"rf_natwet_2007_cv100.rds")
saveRDS(rf_natforest_2007,"rf_natforest_2007_cv100.rds")

saveRDS(rf_natdry_2015,"rf_natdry_2015_cv100.rds")
saveRDS(rf_natwet_2015,"rf_natwet_2015_cv100.rds")
saveRDS(rf_natforest_2015,"rf_natforest_2015_cv100.rds")