library(randomForest)
library(caret)
library(e1071)

intersected=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_both_v2.csv")
intersected_15mforest=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_forest15m.csv")

naturedry=intersected[intersected$HbGrp_x=="Nature dry",]
naturedry_omit_1 <- na.omit(naturedry) 

naturedry_omit=naturedry_omit_1[naturedry_omit_1$HbttID_x==naturedry_omit_1$HbttID_y,]

trainIndex_natdry <- createDataPartition(naturedry_omit$SpRchnss_x, p = .75, 
                                         list = FALSE, 
                                         times = 1)

naturedry_omit_sel_2007=naturedry_omit[,c(9,21:29,5)]
naturedry_omit_sel_2015=naturedry_omit[,c(18,30:38,14)]

naturedry_omit_sel_2007_train <- naturedry_omit_sel_2007[ trainIndex_natdry,]
naturedry_omit_sel_2007_test  <- naturedry_omit_sel_2007[-trainIndex_natdry,]
naturedry_omit_sel_2015_train <- naturedry_omit_sel_2015[ trainIndex_natdry,]
naturedry_omit_sel_2015_test  <- naturedry_omit_sel_2015[-trainIndex_natdry,]

naturewet=intersected[intersected$HbGrp_x=="Nature wet",]
naturewet_omit_1 <- na.omit(naturewet)

naturewet_omit=naturewet_omit_1[naturewet_omit_1$HbttID_x==naturewet_omit_1$HbttID_y,]

trainIndex_natwet <- createDataPartition(naturewet_omit$SpRchnss_x, p = .75, 
                                         list = FALSE, 
                                         times = 1)

naturewet_omit_sel_2007=naturewet_omit[,c(9,21:29,5)]
naturewet_omit_sel_2015=naturewet_omit[,c(18,30:38,14)]

naturewet_omit_sel_2007_train <- naturewet_omit_sel_2007[ trainIndex_natwet,]
naturewet_omit_sel_2007_test  <- naturewet_omit_sel_2007[-trainIndex_natwet,]
naturewet_omit_sel_2015_train <- naturewet_omit_sel_2015[ trainIndex_natwet,]
naturewet_omit_sel_2015_test  <- naturewet_omit_sel_2015[-trainIndex_natwet,]

natureforest=intersected_15mforest[intersected_15mforest$HbGrp_x=="Forest",]
natureforest_omit_1 <- na.omit(natureforest) 

natureforest_omit=natureforest_omit_1[natureforest_omit_1$HbttID_x==natureforest_omit_1$HbttID_y,]

trainIndex_forest <- createDataPartition(natureforest_omit$SpRchnss_x, p = .75, 
                                         list = FALSE, 
                                         times = 1)


natureforest_omit_sel_2007=natureforest_omit[,c(9,21:29,5)]
natureforest_omit_sel_2015=natureforest_omit[,c(18,30:38,14)]

natureforest_omit_sel_2007_train <- natureforest_omit_sel_2007[ trainIndex_forest,]
natureforest_omit_sel_2007_test  <- natureforest_omit_sel_2007[-trainIndex_forest,]
natureforest_omit_sel_2015_train <- natureforest_omit_sel_2015[ trainIndex_forest,]
natureforest_omit_sel_2015_test  <- natureforest_omit_sel_2015[-trainIndex_forest,]

# RF
set.seed(1234)

trControl <- trainControl(method = "repeatedcv",
                          number = 10,
                          repeats=10,
                          search = "grid",
                          p=0.75)

#natdry

rf_natdry_2007 <- train(SpRchnss_x~ .,
                        data = naturedry_omit_sel_2007_train[-11],
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natdry_2007)
varImp(rf_natdry_2007)

rf_natdry_2015 <- train(SpRchnss_y~ .,
                        data = naturedry_omit_sel_2015_train[-11],
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natdry_2015)
varImp(rf_natdry_2015)

#natwet

rf_natwet_2007 <- train(SpRchnss_x~ .,
                        data = naturewet_omit_sel_2007_train[-11],
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natwet_2007)
varImp(rf_natwet_2007)

rf_natwet_2015 <- train(SpRchnss_y~ .,
                        data = naturewet_omit_sel_2015_train[-11],
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natwet_2015)
varImp(rf_natwet_2015)

#forest

rf_natforest_2007 <- train(SpRchnss_x~ .,
                           data = natureforest_omit_sel_2007_train[-11],
                           method = "rf",
                           trControl = trControl,
                           importance=T)

print(rf_natforest_2007)
varImp(rf_natforest_2007)

rf_natforest_2015 <- train(SpRchnss_y~ .,
                           data = natureforest_omit_sel_2015_train[-11],
                           method = "rf",
                           trControl = trControl,
                           importance=T)

print(rf_natforest_2015)
varImp(rf_natforest_2015)

# export rf objects

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/")

saveRDS(rf_natdry_2007,"rf_natdry_2007_rep10cv10_240822_wtrain_v3.rds")
saveRDS(rf_natwet_2007,"rf_natwet_2007_rep10cv10_240822_wtrain_v3.rds")
saveRDS(rf_natforest_2007,"rf_natforest_2007_rep10cv10_240822_wtrain_15m_v3.rds")

saveRDS(rf_natdry_2015,"rf_natdry_2015_rep10cv10_240822_wtrain_v3.rds")
saveRDS(rf_natwet_2015,"rf_natwet_2015_rep10cv10_240822_wtrain_v3.rds")
saveRDS(rf_natforest_2015,"rf_natforest_2015_rep10cv10_240822_wtrain_15m_v3.rds")

write.csv(naturedry_omit_sel_2007_train,"naturedry_omit_sel_2007_train_v3.csv")
write.csv(naturedry_omit_sel_2015_train,"naturedry_omit_sel_2015_train_v3.csv")
write.csv(naturedry_omit_sel_2007_test,"naturedry_omit_sel_2007_test_v3.csv")
write.csv(naturedry_omit_sel_2015_test,"naturedry_omit_sel_2015_test_v3.csv")

write.csv(naturewet_omit_sel_2007_train,"naturewet_omit_sel_2007_train_v3.csv")
write.csv(naturewet_omit_sel_2015_train,"naturewet_omit_sel_2015_train_v3.csv")
write.csv(naturewet_omit_sel_2007_test,"naturewet_omit_sel_2007_test_v3.csv")
write.csv(naturewet_omit_sel_2015_test,"naturewet_omit_sel_2015_test_v3.csv")

write.csv(natureforest_omit_sel_2007_train,"natureforest_omit_sel_2007_train_v3.csv")
write.csv(natureforest_omit_sel_2015_train,"natureforest_omit_sel_2015_train_v3.csv")
write.csv(natureforest_omit_sel_2007_test,"natureforest_omit_sel_2007_test_v3.csv")
write.csv(natureforest_omit_sel_2015_test,"natureforest_omit_sel_2015_test_v3.csv")