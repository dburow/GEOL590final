#Creates empirical semivariogram of raster values
#Correct filepath for line 7
#Uncomment package installation line 6 as needed
#Run lines 6 through 18 first
#Then correct nrow value in line 23 using summary output; run balance of code

##install.packages("gstat")
library(gstat)

#correct filepath below
changerast <- raster(x = "F:/GEOG413/finalproject/newMODISdata/differences/diff_tiffs/coastaldiff2.tif")

#Need dataframe for semivariogram
spatialpoints <- as(changerast, 'SpatialPointsDataFrame')
#There are na values in dataframe from masked out pixels
spatialpoints <- na.omit(spatialpoints)
#Summary command displays how many values there are in the raster
#Will need this number below
summary(spatialpoints)

#create new data frame with lat/lon data in km rather than degrees
#nrow value before should be equal to the number of values in the raster found above
spatialpointskm <- data.frame(matrix(nrow = 69813))
#1 deg lat is ~110 km worldwide
spatialpointskm$y <- 110.*(spatialpoints$y-3800000)/100000
#1 deg lon is ~90 km at this latitude
spatialpointskm$x <- 90.*(spatialpoints$x + 7000000)/100000
#z variable remains unchanged
spatialpointskm$deltaref <- spatialpoints$coastaldiff2

#create and display variogram
thevariogram <- variogram(deltaref~1, loc= ~x + y, data = spatialpointskm)
ggplot(thevariogram, aes(x = dist, y = gamma)) +
  geom_point() + 
  xlab("Distance (km)") +
  ylab("Gamma") + 
  ggtitle("Emp. Semivariogram for Difference Image")