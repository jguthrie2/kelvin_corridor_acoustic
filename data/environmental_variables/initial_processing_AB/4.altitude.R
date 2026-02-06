alt<-rast("dem_50_clipped_buffer.tif")

plot(alt)

climate_data <- terra::extract(alt, RK_buffer)
length(RK_buffer)

RK_buffer$altitude

writeVector(RK_buffer, 'RK_buffer_2.shp', overwrite=T)
