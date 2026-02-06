streetlamps <- vect( "Lighting_Columns.shp" )
crs(streetlamps)<-crs(RK_buffer)
plot(streetlamps)
head(streetlamps)

dist_streetlamps <- terra::distance(RK_buffer, streetlamps)
dim(dist_streetlamps)
df = rowMins(dist_streetlamps)
RK_buffer$dist_streetlamps <- df

head(RK_buffer)

plot(RK_buffer)

writeVector(RK_buffer, 'RK_buffer_2.shp', overwrite=T)
