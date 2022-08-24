library(randomForest)
library(caret)
library(e1071)

library(ggplot2)
library(gridExtra)
library(grid)

# Import RF objects

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/")

## Nature dry

rf_natdry_2007=readRDS("rf_natdry_2007_rep10cv10_230822.rds")
rf_natdry_2015=readRDS("rf_natdry_2015_rep10cv10_230822.rds")

intersected=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_both_v2.csv")
intersected_15mforest=read.csv("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/plt_db_wlidar_forest15m.csv")

naturedry=intersected[intersected$HbGrp_x=="Nature dry",]
naturedry_omit_1 <- na.omit(naturedry) 

naturedry_omit=naturedry_omit_1[naturedry_omit_1$HbttID_x==naturedry_omit_1$HbttID_y,]

trainIndex_natdry <- createDataPartition(naturedry_omit$SpRchnss_x, p = .75, 
                                         list = FALSE, 
                                         times = 1)

naturedry_omit_sel_2007=naturedry_omit[,c(9,21:29)]
naturedry_omit_sel_2015=naturedry_omit[,c(18,30:38)]

# predict

pred_natdry_2007=predict(rf_natdry_2007,newdata = naturedry_omit_sel_2007[-1])
pred_natdry_2007_r=as.data.frame(pred_natdry_2007)
naturedry_omit_sel_2007$pred=pred_natdry_2007_r


p1=ggplot(data=naturedry_omit_sel_2007,aes(x=round(pred$pred_natdry_2007,1),y=SpRchnss_x))+
  geom_point(size=3,show.legend = FALSE)+
  geom_smooth(method = "lm", se = FALSE, colour="black",size=2)+
  geom_abline()+
  xlab("Predicted richness")+
  ylab("Observed richness")+
  theme_bw(base_size = 25)