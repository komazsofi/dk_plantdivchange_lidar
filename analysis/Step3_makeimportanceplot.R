library(randomForest)
library(caret)
library(e1071)

library(ggplot2)
library(gridExtra)
library(grid)

# Import RF objects

setwd("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/")

## Import data

#rf_natdry_2007=readRDS("rf_natdry_2007_rep10cv10_240822_wtrain_v3.rds")
#rf_natdry_2015=readRDS("rf_natdry_2015_rep10cv10_240822_wtrain_v3.rds")

#rf_natdry_2007=readRDS("rf_natwet_2007_rep10cv10_240822_wtrain_v3.rds")
#rf_natdry_2015=readRDS("rf_natwet_2015_rep10cv10_240822_wtrain_v3.rds")

rf_natdry_2007=readRDS("rf_natforest_2007_rep10cv10_240822_wtrain_15m_v3.rds")
rf_natdry_2015=readRDS("rf_natforest_2015_rep10cv10_240822_wtrain_15m_v3.rds")

rf_natdry_2007=readRDS("rf_natdry_ch_rep10cv10_240822_wtrain_v2.rds")
rf_natdry_2007=readRDS("rf_natwet_ch_rep10cv10_240822_wtrain_v2.rds")
rf_natdry_2007=readRDS("rf_natforest_ch_rep10cv10_240822_wtrain_15m_v2.rds")

# reorganize feature importance

feaimp_natdry_df_2007=as.data.frame(rf_natdry_2007[["finalModel"]][["importance"]])
feaimp_natdry_df_2007$metrics <- c("veg_vert_sd","het_prop_shrub","het_height_sd","het_veg_dens_sd","topo_slope","topo_solar_rad","topo_twi",
                                   "veg_dens","veg_height")

feaimp_natdry_df_2007$FeaGroup=NA

feaimp_natdry_df_2007$FeaGroup[feaimp_natdry_df_2007$metrics=='veg_vert_sd' |feaimp_natdry_df_2007$metrics=='veg_dens' |feaimp_natdry_df_2007$metrics=='veg_height' ]="Vegetation"

feaimp_natdry_df_2007$FeaGroup[feaimp_natdry_df_2007$metrics=='topo_slope' | feaimp_natdry_df_2007$metrics=='topo_solar_rad' | feaimp_natdry_df_2007$metrics=='topo_twi']="Topography"

feaimp_natdry_df_2007$FeaGroup[feaimp_natdry_df_2007$metrics=='het_prop_shrub' | feaimp_natdry_df_2007$metrics=='het_height_sd' | feaimp_natdry_df_2007$metrics=='het_veg_dens_sd']="Heterogeneity"

names(feaimp_natdry_df_2007)[1] <- "meanImp"

feaimp_natdry_df_sort_2007 <- feaimp_natdry_df_2007[order(feaimp_natdry_df_2007$meanImp,decreasing = TRUE), ]
feaimp_natdry_df_sort_n5_2007=head(feaimp_natdry_df_sort_2007,n=5)

#plotting

p1=ggplot(feaimp_natdry_df_sort_2007, aes(x=metrics, y=meanImp, color=as.factor(FeaGroup))) + 
  geom_point(size=5,show.legend = FALSE) +
  geom_segment(aes(x=metrics,xend=metrics,y=0,yend=meanImp),size=3,show.legend = FALSE) +
  ylab("%IncMSE") +
  xlab("Metrics") +
  ylim(c(0,15))+
  coord_flip()+
  theme_bw(base_size = 30)+
  ggtitle("2006/2007")+
  scale_color_manual(values = c("Vegetation"="deeppink2","Topography"="deepskyblue1","Heterogeneity"="forestgreen"),name="Type of metrics")

feaimp_natdry_df_2015=as.data.frame(rf_natdry_2015[["finalModel"]][["importance"]])
feaimp_natdry_df_2015$metrics <- c("veg_vert_sd","het_prop_shrub","het_height_sd","het_veg_dens_sd","topo_slope","topo_solar_rad","topo_twi",
                                   "veg_dens","veg_height")

feaimp_natdry_df_2015$FeaGroup=NA

feaimp_natdry_df_2015$FeaGroup[feaimp_natdry_df_2015$metrics=='veg_vert_sd' |feaimp_natdry_df_2015$metrics=='veg_dens' |feaimp_natdry_df_2015$metrics=='veg_height' ]="Vegetation"

feaimp_natdry_df_2015$FeaGroup[feaimp_natdry_df_2015$metrics=='topo_slope' | feaimp_natdry_df_2015$metrics=='topo_solar_rad' | feaimp_natdry_df_2015$metrics=='topo_twi']="Topography"

feaimp_natdry_df_2015$FeaGroup[feaimp_natdry_df_2015$metrics=='het_prop_shrub' | feaimp_natdry_df_2015$metrics=='het_height_sd' | feaimp_natdry_df_2015$metrics=='het_veg_dens_sd']="Heterogeneity"

names(feaimp_natdry_df_2015)[1] <- "meanImp"

feaimp_natdry_df_sort_2015 <- feaimp_natdry_df_2015[order(feaimp_natdry_df_2015$meanImp,decreasing = TRUE), ]
feaimp_natdry_df_sort_n5_2015=head(feaimp_natdry_df_sort_2015,n=5)

p2=ggplot(feaimp_natdry_df_2015, aes(x=metrics, y=meanImp, color=as.factor(FeaGroup))) + 
  geom_point(size=5,show.legend = FALSE) +
  geom_segment(aes(x=metrics,xend=metrics,y=0,yend=meanImp),size=3,show.legend = FALSE) +
  ylab("%IncMSE") +
  xlab("Metrics") +
  ylim(c(0,100))+
  coord_flip()+
  theme_bw(base_size = 30)+
  ggtitle("2014/2015")+
  scale_color_manual(values = c("Vegetation"="deeppink2","Topography"="deepskyblue1","Heterogeneity"="forestgreen"),name="Type of metrics")

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

p0=ggplot(feaimp_natdry_df_sort_2007, aes(x=reorder(metrics, meanImp), y=meanImp, color=as.factor(FeaGroup)),show.legend = TRUE) + 
  geom_point(size=5) +
  geom_segment(aes(x=metrics,xend=metrics,y=0,yend=meanImp),size=3) +
  ylab("%IncMSE") +
  xlab("Metrics") +
  coord_flip()+
  theme_bw(base_size = 30)+
  scale_color_manual(values = c("Vegetation"="deeppink2","Topography"="deepskyblue1","Heterogeneity"="forestgreen"),name="Type of metrics")

legend <- get_legend(p0)

fig_natdry=grid.arrange(
  p1,p2,
  ncol=2,
  nrow=1,
  widths = c(1,1)
)

ggsave("O:/Nat_Sustain-proj/_user/ZsofiaKoma_au700510/PlantDivChange_lidar/processing_082022/fig_natdry.png",plot = fig_natdry,width = 32, height =15)