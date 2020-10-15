

######################################
## test alkey and catch-at-age for year 2013
y.2013 <- y[y$year==2013,]
z.2013 <- z[z$year==2013 & z$age!=99,]
key <- alkey(z.2013)
##key.r <- resize(key, len = 0:100, age = 0:9)
##key.f <- fill(key.r, nmin = 5) # Interpolate missing or weak probabilities.  

x.2013 <- x[x$year==2013,] ##  & x$stratum %in% c(415:439)
yl.2013 <- yl[yl$year==2013,]

gulf.map(xlim=c(-62.5,-61.5), ylim=c(47,48))
plot.polygon(stratum.polygons())
segments(x.2013$longitude.start[20],x.2013$latitude.start[20], x.2013$longitude.end[20],x.2013$latitude.end[20], col="red")
x.2013[20,]

stratum(longitude(x.2013),latitude(x.2013)) == x.2013$stratum
stratum(longitude(x.2013),latitude(x.2013))[20]
x.2013[20,]

# x.2013 <- x.2013[c(1:19,21:132),]

##f.2013 <- freq(yl.2013, by="set.number")
## match.data.frame(x.2013, f.2013)
yl.2013 <- merge.length(x.2013, yl.2013)

lvars <- as.character(5:61)

caa <- catch.at.age(yl.2013, key)

tt <- x.2013[x.2013$set.number %in% c(33,34),]
stratum(longitude(tt),latitude(tt)) == tt$stratum
yl.2013[yl.2013$set.number %in% c(33,34),]

x.2013[,avars] <- caa[,avars]

res <- smean.rvset(x.2013, avars)



x.2013[x.2013$set.number %in% c(118,119),]
y.2013[y.2013$set.number %in% c(118,119),]
yl.2013[yl.2013$set.number %in% c(118,119),]
