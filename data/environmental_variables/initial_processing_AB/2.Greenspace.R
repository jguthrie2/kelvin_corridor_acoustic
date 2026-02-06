dir <- "Download_Master+greenspace+_2358199/MasterMap Greenspace_5228130/ns"

ff <- list.files(dir, pattern="\\.shp$", full.names=TRUE)

v <- vect( lapply(ff, vect) )


y <- values(v)
head(y)
unique(y$priFunc)

gs <- split(v, "priFunc")

unique(gs)

## greenspace types, from: OS MasterMap Greenspace Layer

# privateGarden <- gs[[14]]
# 
# dist_privateGarden <- terra::distance(RK_buffer, privateGarden)
# dim(dist_privateGarden)
# df = rowMins(dist_privateGarden)
# RK_buffer$dist_privateGarden <- df

Allotments <- gs[[1]]
dist_allotments <- terra::distance(RK_buffer, Allotments)
dim(dist_allotments)
df = rowMins(dist_allotments)
RK_buffer$dist_allotments <- df

Cemetery <- gs[[6]]
dist_Cemetery <- terra::distance(RK_buffer, Cemetery)
dim(dist_Cemetery)
df = rowMins(dist_Cemetery)
RK_buffer$dist_Cemetery <- df

# amenity <- rbind(gs[[2]], gs[[3]], gs[[4]], gs[[5]], gs[[7]], gs[[8]], gs[[11]], gs[[16]], gs[[17]], gs[[18]])
# unique(amenity$priFunc)
# plot(amenity)
# dist_amenity <- terra::distance(RK_buffer, amenity)
# dim(dist_amenity)
# df = rowMins(dist_amenity)
# RK_buffer$dist_amenity <- df

# gs[[13]]
# 
# parks_playspace <- rbind(gs[[12]], gs[[13]], gs[[15]])
# parks <- gs[[15]]
# unique(parks_playspace$priFunc)
# # plot(parks_playspace)
# dist_parks_playspace <- terra::distance(RK_buffer, parks_playspace)
# dim(dist_parks_playspace)
# df = rowMins(dist_parks_playspace)
# RK_buffer$dist_parks_playspace <- df

parks <- gs[[15]]
crs(parks)<-crs(RK_buffer)
plot(parks)
dist_parks <- terra::distance(RK_buffer, parks)
dim(dist_parks)
df = rowMins(dist_parks)
RK_buffer$dist_parks <- df

writeVector(RK_buffer, 'RK_buffer_2.shp', overwrite=T)

head(RK_buffer)
