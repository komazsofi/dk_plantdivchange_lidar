library(randomForest)
library(caret)
library(e1071)

library(ggplot2)
library(gridExtra)
library(grid)

# Import RF objects

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/")

## Nature dry

rf_natdry_2007=readRDS("rf_natdry_2007_rep10cv10_240822_wtrain_v3.rds")
rf_natdry_2015=readRDS("rf_natdry_2015_rep10cv10_240822_wtrain_v3.rds")

natdry_2007_train=read.csv("naturedry_omit_sel_2007_train_v3.csv")
natdry_2015_train=read.csv("naturedry_omit_sel_2015_train_v3.csv")
natdry_2007_test=read.csv("naturedry_omit_sel_2007_test_v3.csv")
natdry_2015_test=read.csv("naturedry_omit_sel_2015_test_v3.csv")

## Forest

rf_natdry_2007=readRDS("rf_natforest_2007_rep10cv10_240822_wtrain_15m_v3.rds")
rf_natdry_2015=readRDS("rf_natforest_2015_rep10cv10_240822_wtrain_15m_v3.rds")

natdry_2007_train=read.csv("natureforest_omit_sel_2007_train_v3.csv")
natdry_2015_train=read.csv("natureforest_omit_sel_2015_train_v3.csv")
natdry_2007_test=read.csv("natureforest_omit_sel_2007_test_v3.csv")
natdry_2015_test=read.csv("natureforest_omit_sel_2015_test_v3.csv")

# predict

pred_natdry_2007_train=as.data.frame(round(predict(rf_natdry_2007,newdata = natdry_2007_train[3:11]),0))
pred_natdry_2007_test=as.data.frame(round(predict(rf_natdry_2007,newdata = natdry_2007_test[3:11]),0))

names(pred_natdry_2007_train)<-"pred2007"
names(pred_natdry_2007_test)<-"pred2007"

pred_natdry_2007_train$predtype<-"train"
pred_natdry_2007_test$predtype<-"test"

pred_natdry=rbind(pred_natdry_2007_train,pred_natdry_2007_test)
pred_natdry=pred_natdry[,1:2]
names(pred_natdry)<-c("pred","type")

naturdry_df=rbind(natdry_2007_train,natdry_2007_test)
naturdry_df_wpred=cbind(naturdry_df,pred_natdry)

###

pred_natdry_2015_train=as.data.frame(round(predict(rf_natdry_2015,newdata = natdry_2015_train[3:11]),0))
pred_natdry_2015_test=as.data.frame(round(predict(rf_natdry_2015,newdata = natdry_2015_test[3:11]),0))

names(pred_natdry_2015_train)<-"pred2015"
names(pred_natdry_2015_test)<-"pred2015"

pred_natdry_2015_train$predtype<-"train"
pred_natdry_2015_test$predtype<-"test"

pred_natdry_2015=rbind(pred_natdry_2015_train,pred_natdry_2015_test)
pred_natdryv=pred_natdry_2015[,1:2]
names(pred_natdry_2015)<-c("pred","type")

naturdry_df_2015=rbind(natdry_2015_train,natdry_2015_test)
naturdry_df_wpred_2015=cbind(naturdry_df_2015,pred_natdry_2015)

## rename labels to english

naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="GrÃ¥/grÃ¸n klit",12]<-"Dune"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="Klitlavning",12]<-"Dune"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="Klithede",12]<-"Dune"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="TÃ¸r hede",12]<-"Heathland"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="Surt overdrev",12]<-"Grassland"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="Kalkoverdrev",12]<-"Grassland"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="EnebÃ¦rklit",12]<-"Heathland"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="Enekrat",12]<-"Heathland"
naturdry_df_wpred[naturdry_df_wpred$Habtt_x=="TÃ¸r overdrev pÃ¥ kalkholdigt sand",12]<-"Dune"

naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="GrÃ¥/grÃ¸n klit",12]<-"Dune"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="Klitlavning",12]<-"Dune"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="Klithede",12]<-"Dune"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="TÃ¸r hede",12]<-"Heathland"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="Surt overdrev",12]<-"Grassland"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="Kalkoverdrev",12]<-"Grassland"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="EnebÃ¦rklit",12]<-"Heathland"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="Enekrat",12]<-"Heathland"
naturdry_df_wpred_2015[naturdry_df_wpred_2015$Habtt_y=="TÃ¸r overdrev pÃ¥ kalkholdigt sand",12]<-"Dune"

# plotting

p1=ggplot(data=naturdry_df_wpred,aes(x=pred,y=SpRchnss_x))+
  geom_point(aes(shape=type,color=Habtt_x),size=3,show.legend = FALSE)+
  geom_abline()+
  xlab("Predicted richness")+
  ylab("Observed richness")+
  theme_bw(base_size = 25)+
  scale_color_manual(values = c("Dune"="deeppink2","Grassland"="chartreuse4","Heathland"="darkorange3"),name="Main habitats")

p2=ggplot(data=naturdry_df_wpred_2015,aes(x=pred,y=SpRchnss_y))+
  geom_point(aes(shape=type,color=Habtt_y),size=3,show.legend = FALSE)+
  geom_abline()+
  xlab("Predicted richness")+
  ylab("Observed richness")+
  theme_bw(base_size = 25)+
  scale_color_manual(values = c("Dune"="deeppink2","Grassland"="chartreuse4","Heathland"="darkorange3"),name="Main habitats")

#just test-rain 

p1x=ggplot(data=naturdry_df_wpred,aes(x=pred,y=SpRchnss_x))+
  geom_point(aes(color=type),size=3,show.legend = FALSE)+
  geom_abline()+
  xlab("Predicted richness")+
  ylab("Observed richness")+
  theme_bw(base_size = 25)

p2x=ggplot(data=naturdry_df_wpred_2015,aes(x=pred,y=SpRchnss_y))+
  geom_point(aes(color=type),size=3,show.legend = FALSE)+
  geom_abline()+
  xlab("Predicted richness")+
  ylab("Observed richness")+
  theme_bw(base_size = 25)