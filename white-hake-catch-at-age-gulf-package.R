## white hake catch-at-age in Sept. survey
library(gulf)

load("../gulf/data/rv.Rda")
## sets
x <- rv$set[rv$set$experiment==1,]
## catch 
y <- rv$cat[rv$cat$species==12,]
## length
yl <- rv$len[rv$len$species==12,]
## bio cards
z <- rv$bio[rv$bio$species==12,]

######################################
## test alkey and catch-at-age for year 2013
y.2013 <- y[y$year==2013,]
z.2013 <- z[z$year==2013 & z$age!=99,]
key <- alkey(z.2013)
##key.r <- resize(key, len = 0:100, age = 0:9)
##key.f <- fill(key.r, nmin = 5) # Interpolate missing or weak probabilities.  

x.2013 <- x[x$year==2013,]
yl.2013 <- yl[yl$year==2013,]

##f.2013 <- freq(yl.2013, by="set.number")
## match.data.frame(x.2013, f.2013)
yl.2013 <- merge.length(x.2013, yl.2013)

caa <- catch.at.age(yl.2013,key)

avars <- as.character(0:6)
res <- smean.rvset(caa, variables=avars)

