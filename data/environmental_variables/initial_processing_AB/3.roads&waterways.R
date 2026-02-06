roads_glasgow <- vect("Roads_5m_buffer.shp")

y = values(roads_glasgow)
head(y)
unique(y$"function")

roads_glasgow <- split(roads_glasgow, "function")
# unique(roads_glasgow[[8]]$`function`)

motorways <- roads_glasgow[[6]]
dist_motorways <- terra::distance(RK_buffer, motorways)
dim(dist_motorways)
df = rowMins(dist_motorways)
RK_buffer$dist_motorways <- df

major_roads <- rbind(roads_glasgow[[1]], roads_glasgow[[2]])
unique(major_roads$`function`)
dist_major_roads <- terra::distance(RK_buffer, major_roads)
dim(dist_major_roads)
df = rowMins(dist_major_roads)
RK_buffer$dist_major_roads <- df

minor_roads <- rbind(roads_glasgow[[3]], roads_glasgow[[4]], roads_glasgow[[5]], roads_glasgow[[7]], roads_glasgow[[8]])
unique(minor_roads$`function`)
dist_minor_roads <- terra::distance(RK_buffer, minor_roads)
dim(dist_minor_roads)
df = rowMins(dist_minor_roads)
RK_buffer$dist_minor_roads <- df

writeVector(RK_buffer, 'RK_buffer_2.shp', overwrite=T)

##############waterways
ww_glasgow <- vect( "Waterways_5m_buffer.shp" )

y = values(ww_glasgow)
head(y)
unique(y$"form")

ww_glasgow <- split(ww_glasgow, "form")
unique(ww_glasgow[[4]]$`form`)

canal <- ww_glasgow[[1]]

dist_canal <- terra::distance(RK_buffer, canal)
dim(dist_canal)
df = rowMins(dist_canal)
RK_buffer$dist_canal <- df

lake <- ww_glasgow[[3]]
dist_lake <- terra::distance(RK_buffer, lake)
dim(dist_lake)
df = rowMins(dist_lake)
RK_buffer$dist_lake <- df

river <- rbind(ww_glasgow[[2]], ww_glasgow[[4]])
dist_river <- terra::distance(RK_buffer, river)
dim(dist_river)
df = rowMins(dist_river)
RK_buffer$dist_river <- df

writeVector(RK_buffer, 'RK_buffer_2.shp', overwrite=T)
write.csv(RK_buffer, 'RK_buffer_2.csv')
head(RK_buffer)
