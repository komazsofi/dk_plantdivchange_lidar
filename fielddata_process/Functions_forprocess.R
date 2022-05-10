
habitatgrouping=function(data_plot_forshp_biow_df) {
  
  data_plot_forshp_biow_df$HabGroup=NA
  
  data_plot_forshp_biow_df$HabGroup[data_plot_forshp_biow_df$HabitatID == 1210 |data_plot_forshp_biow_df$HabitatID == 1220 |data_plot_forshp_biow_df$HabitatID == 1230 |
                                      data_plot_forshp_biow_df$HabitatID == 2110 |data_plot_forshp_biow_df$HabitatID == 2120 |data_plot_forshp_biow_df$HabitatID == 2130
                                    |data_plot_forshp_biow_df$HabitatID == 2140 | data_plot_forshp_biow_df$HabitatID == 2160 |data_plot_forshp_biow_df$HabitatID == 2170
                                    |data_plot_forshp_biow_df$HabitatID == 2190 |data_plot_forshp_biow_df$HabitatID == 2250 |data_plot_forshp_biow_df$HabitatID == 2310
                                    |data_plot_forshp_biow_df$HabitatID == 2330 | data_plot_forshp_biow_df$HabitatID == 4030 |data_plot_forshp_biow_df$HabitatID == 5130
                                    |data_plot_forshp_biow_df$HabitatID == 6120 |data_plot_forshp_biow_df$HabitatID == 6210 |data_plot_forshp_biow_df$HabitatID == 6230
                                    |data_plot_forshp_biow_df$HabitatID == 8220]="Nature dry"
  
  data_plot_forshp_biow_df$HabGroup[data_plot_forshp_biow_df$HabitatID == 1310 |data_plot_forshp_biow_df$HabitatID == 1320 |data_plot_forshp_biow_df$HabitatID == 1330 |
                                      data_plot_forshp_biow_df$HabitatID == 1340 |data_plot_forshp_biow_df$HabitatID == 4010 |data_plot_forshp_biow_df$HabitatID == 6410
                                    |data_plot_forshp_biow_df$HabitatID == 7120 | data_plot_forshp_biow_df$HabitatID == 7140 |data_plot_forshp_biow_df$HabitatID == 7150
                                    |data_plot_forshp_biow_df$HabitatID == 7210 |data_plot_forshp_biow_df$HabitatID == 7220 |data_plot_forshp_biow_df$HabitatID == 7230]="Nature wet"
  
  data_plot_forshp_biow_df$HabGroup[data_plot_forshp_biow_df$HabitatID == 9100 ]="Forest"
  
  return(data_plot_forshp_biow_df)
}

convert_to_shp=function(data_plot_forshp) {
  
  data_plot_forshp$UTM_X=data_plot_forshp$UTM_X_orig
  data_plot_forshp$UTM_Y=data_plot_forshp$UTM_Y_orig
  
  coordinates(data_plot_forshp)=~UTM_X+UTM_Y
  proj4string(data_plot_forshp)<- CRS("+proj=utm +zone=32 +ellps=intl +towgs84=-87,-98,-121,0,0,0,0 +units=m +no_defs ")
  
  return(data_plot_forshp)
}