# Assignment: ASSIGNMENT 11.2
# Name: Ramirez, Kyle
# Date: 2022-03-05


## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())
library(gstat)
library(sp)
library(sf)
library(dismo)
library(tmap)

## Set the working directory to the root of your DSC 520 directory
setwd("/Users/Kyle/Documents/GitHub/KR/Ramirez_Kyle_DSC510/dsc520")

## Load the `data/r4ds/Project/binary-classifier-data` to
binary_df <- read.csv("data/Project/binary-classifier-data.csv")

## Load the `data/r4ds/Project/trinary-classifier-data` to
trinary_df <- read.csv("data/Project/trinary-classifier-data.csv")

## `x` vs. `y` binary
ggplot(binary_df, aes(x=x, y=y)) + geom_point() + geom_smooth()

## `x` vs. `y` trinary
ggplot(trinary_df, aes(x=x, y=y)) + geom_point() + geom_smooth()

## check data
head(binary_df)

## spatial data frame. Point data set with data frame. Get x and y coordinate. Get data frame. Get CRS from SP package
f_spdf - sp::SpatialPointsDataFrame(coords - cbind(binary_df$x,binary_df$y), data - binary_df, proj4string = sp::CRS(projargs = "+init=espg:32631"))

## create voronoi polygon
vp = dismo::voronoi(xy = f_spdf)

## plot to check visual
plot(vp)

## convert data set to sf version
f_sf = sf::st_as_sf(x = f_spdf)

## convert the polygons to sf version
vp_sf = sf:st_as_sf(x = vp)

## spatial joining. Takes in 2 parameters of 2 geometry's to join. X is output geometry
vp_join = sf::st_join(x = vp_sf, y = f_sf)

## create tmap
tmap = tm_shape(shp = vp_join) + tm_polygons(col = "label")

