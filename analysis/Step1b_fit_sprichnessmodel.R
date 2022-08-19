library(randomForest)
library(caret)
library(e1071)

intersected=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_both_v2.csv")

naturedry=intersected[intersected$HbGrp_x=="Nature dry",]
naturedry_omit <- na.omit(naturedry) 

trainIndex_natdry <- createDataPartition(naturedry_omit$SpRchnss_x, p = .75, 
                                  list = FALSE, 
                                  times = 1)

naturedry_omit_sel_2007=naturedry_omit[,c(9,21:29)]
naturedry_omit_sel_2015=naturedry_omit[,c(18,30:38)]

naturedry_omit_sel_2007_train <- naturedry_omit_sel_2007[ trainIndex_natdry,]
naturedry_omit_sel_2007_test  <- naturedry_omit_sel_2007[-trainIndex_natdry,]
naturedry_omit_sel_2015_train <- naturedry_omit_sel_2015[ trainIndex_natdry,]
naturedry_omit_sel_2015_test  <- naturedry_omit_sel_2015[-trainIndex_natdry,]

naturewet=intersected[intersected$HbGrp_x=="Nature wet",]
naturewet_omit <- na.omit(naturewet)

trainIndex_natwet <- createDataPartition(naturewet_omit$SpRchnss_x, p = .75, 
                                         list = FALSE, 
                                         times = 1)

naturewet_omit_sel_2007=naturewet_omit[,c(9,21:29)]
naturewet_omit_sel_2015=naturewet_omit[,c(18,30:38)]

naturewet_omit_sel_2007_train <- naturewet_omit_sel_2007[ trainIndex_natwet,]
naturewet_omit_sel_2007_test  <- naturewet_omit_sel_2007[-trainIndex_natwet,]
naturewet_omit_sel_2015_train <- naturewet_omit_sel_2015[ trainIndex_natwet,]
naturewet_omit_sel_2015_test  <- naturewet_omit_sel_2015[-trainIndex_natwet,]

natureforest=intersected[intersected$HbGrp_x=="Forest",]
natureforest_omit <- na.omit(natureforest) 

trainIndex_forest <- createDataPartition(natureforest_omit$SpRchnss_x, p = .75, 
                                         list = FALSE, 
                                         times = 1)


natureforest_omit_sel_2007=natureforest_omit[,c(9,21:29)]
natureforest_omit_sel_2015=natureforest_omit[,c(18,30:38)]

natureforest_omit_sel_2007_train <- natureforest_omit_sel_2007[ trainIndex_forest,]
natureforest_omit_sel_2007_test  <- natureforest_omit_sel_2007[-trainIndex_forest,]
natureforest_omit_sel_2015_train <- natureforest_omit_sel_2015[ trainIndex_forest,]
natureforest_omit_sel_2015_test  <- natureforest_omit_sel_2015[-trainIndex_forest,]

# RF
set.seed(1234)

trControl <- trainControl(method = "repeatedcv",
                          number = 10,
                          repeats=5,
                          search = "grid",
                          p=0.75)

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

rf_natforest_2007 <- train(as.double(SpRchnss_x)~ .,
                        data = natureforest_omit_sel_2007_train,
                        method = "rf",
                        trControl = trControl,
                        importance=T)

print(rf_natforest_2007)
varImp(rf_natforest_2007)

actual <- natureforest_omit_sel_2007_test$SpRchnss_x
predicted <- unname(predict(rf_natforest_2007, natureforest_omit_sel_2007_test[-1]))
R2 <- 1 - (sum((actual-predicted)^2)/sum((actual-mean(actual))^2))
print(R2)
print(RMSE(predicted,actual))

rf_natforest_2015 <- train(SpRchnss_y~ .,
                        data = natureforest_omit_sel_2015_train,
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