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
z.2013 <- z[z$year==2013 & z$age!=99,]
key <- alkey(z.2013)
##key.r <- resize(key, len = 0:100, age = 0:9)
##key.f <- fill(key.r, nmin = 5) # Interpolate missing or weak probabilities.  

yl.2013 <- yl[yl$year==2013,]

f <- freq(yl.2013, by="set.number")
caa <- catch.at.age(f, key)
lvars <- as.character(0:6)
res <- smean(caa, lvars)

