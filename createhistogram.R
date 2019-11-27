#Creates histogram of values in tiff representing change in red reflectance
#Will need to correct filepath in Line 11
#Uncomment package installation commands (line 5-6) as needed

##install.packages("ggplot2")
##install.packages("raster")
library(ggplot2)
library(raster)

#correct filepath below
changerast <- raster(x = "F:/GEOG413/finalproject/newMODISdata/differences/diff_tiffs/coastaldiff2.tif")

#ggplot needs values in a dataframe to create histogram
change_df <- as.data.frame(values(changerast))

#There are a few na values in the dataframe that need to be excluded
df_filter <- na.omit(change_df)

hist <- ggplot(df_filter, aes(df_filter$`values(changerast)`)) + geom_density(alpha=0.2)

#display histogram
hist + ggtitle("Change in Reflectance") + 
  xlab("Reflectance x 100") + 
  ylab("Density") + 
  xlim(-200, 200) +
  theme(legend.title = element_blank())