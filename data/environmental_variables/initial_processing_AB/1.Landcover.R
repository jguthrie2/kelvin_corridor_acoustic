
RK_points <- vect("riverkelvinsites.shp")
crs(RK_points)
plot(RK_points)

head(RK_points)

RK_buffer <- terra::buffer(RK_points,
                                width = 125) 
head(RK_buffer)
tail(RK_buffer)
points(RK_points, col = 'red')


LC<-rast("LCM.tif")

int.list07 <- list()
for (i in 1:length(RK_buffer)){
  int.list07[[i]] <- terra::extract(LC, RK_buffer[i,])
  print(i)
}

head(int.list07[[1]]) 

ss <- lapply(int.list07, "[", 2)

unique

unique(ss[[1]]) 

landcover <- data.frame(matrix(NA, nrow = length(RK_buffer),
                               ncol = 21))

names(landcover) <- c( "1","2","3","4","5","6", "7", "8", "9", "10",
                       "11", "12", "13", "14", "15", "16", "17", "18",
                       "19", "20", "21")
head(landcover)

for (i in 1:length(RK_buffer)){
  for ( j in 1:length(names(landcover))) {
    landcover[i,j] <- table(
      ss[[i]])[as.character(names(landcover)[j])]
  }}

names(landcover) <- c("Broadleaved woodland",
                      "Coniferous woodland",
                      "Arable",
                      "Improved grassland",
                      "Neutral grassland",
                      "Calcareous grassland",
                      "Acid grassland",
                      "Fen, marsh and swamp",
                      "Heather and shrub",
                      "Heather grassland",
                      "Bog",
                      "Inland rock",
                      "Saltwater",
                      "Freshwater",
                      "Supralittoral rock",
                      "Supralittoral sediment",
                      "Littoral rock",
                      "Littoral sediment",
                      "Saltmarsh",
                      "Urban",
                      "Suburban")

landcover[is.na(landcover)] <- 0
row_sum <- rowSums(landcover)
row_sum
prop <- landcover/row_sum
prop <- round(prop, 3)

prop[is.na(prop)] <- 0

head(RK_buffer)

RK_buffer$prop_woodland <- 0
RK_buffer$prop_wetland <- 0
RK_buffer$prop_urban <- 0
RK_buffer$prop_freshwater <- 0
RK_buffer$prop_grassland <- 0
RK_buffer$prop_arable <- 0
RK_buffer$prop_montane <- 0
RK_buffer$prop_heather <- 0
RK_buffer$prop_coastal <- 0

names(prop)

RK_buffer$prop_woodland <- rowSums(prop[,c(1,2)])# broadleaf and conifer
RK_buffer$prop_wetland <- rowSums(prop[,c(11,8)])# fen,marsh,swamp,bog
RK_buffer$prop_urban <- rowSums(prop[,c(20,21)])# urban suburban
RK_buffer$prop_freshwater <- prop[,c(14)] #freshwater
RK_buffer$prop_grassland <- rowSums(prop[,c(4,5,6,7,10)]) # improved, heather, neutral, calcareous, acid
RK_buffer$prop_arable <- prop[,c(3)] #arable
RK_buffer$prop_montane <- prop[,c(12)] # inland rock
RK_buffer$prop_heather <- prop[,c(9)] #heather
RK_buffer$prop_coastal <- rowSums(prop[,c(13, 15,16,17,18,19)]) #supralittoral/littoral rock/sediment, saltmarsh, sea

head(RK_buffer)

writeVector(RK_buffer, 'RK_buffer_2.shp')

