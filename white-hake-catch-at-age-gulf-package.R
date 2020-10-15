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
## table(z$year, is.na(z$age))

## generate yearly stratified catch-at-age 
## 2011
x.2011 <- x[x$year==2011,]
yl.2011 <- yl[yl$year==2011,]
yl.2011 <- merge.length(x.2011, yl.2011)

z.2011 <- z[z$year==2011 & z$age!=99,]

key <- alkey(z.2011)
key.r <- resize(key, len = 0:100, age = 0:9)
key.f <- fill(key.r, nmin = 5) # Interpolate missing or weak probabilities.  

caa.2011 <- catch.at.age(yl.2011, key)
caa.2011.r <- catch.at.age(yl.2011, key.r)
caa.2011.f <- catch.at.age(yl.2011, key.f)

avars <- as.character(0:6)
x.2011[,avars] <- caa.2011[,avars]
res <- smean.rvset(x.2011, avars)

avars <- as.character(0:9)
x.2011[,avars] <- caa.2011.r[,avars]
res.r <- smean.rvset(x.2011, avars)
x.2011[,avars] <- caa.2011.f[,avars]
res.f <- smean.rvset(x.2011, avars)

## so seemingly the only option that works is the smoothed/filled age-length key


## table(z$year, (is.na(z$age) | z$age==99))

## 
years <- c(1978,1979,1981:2019)
res.df <- data.frame(year=years)
avars <- as.character(0:max(z[z$age!=99,"age"], na.rm=T))
res.df[,avars] <- NA


for(y in years){
  ## y <- 1981
  print(y)
  this.x <- x[x$year==y & x$stratum %in% c(415:429,431:439),]
  this.yl <- yl[yl$year==y,]
  this.yl <- merge.length(this.x, this.yl)
  
  ## no ageing after 2014, so use a combined 2013-2014 key for 2015 to 2019
  if(y<2015){
    this.z <- z[z$year==y & z$age!=99,]
    key <- alkey(this.z)
  } else {
    this.z <- z[z$year %in% c(2013,2014) & z$age!=99,]
    key <- alkey(this.z)
  }
  
  ma <- max(summary(key)$ages)
  ml <- max(summary(key)$lengths)
  key.r <- resize(key, len = 0:ml, age = 0:ma)
  key.f <- fill(key.r, nmin = 5) # Interpolate missing or weak probabilities.  
  
  this.caa <- catch.at.age(this.yl, key.f)
  
  avars <- as.character(0:ma)
  this.x[,avars] <- this.caa[,avars]
  res <- smean.rvset(this.x, avars)
  res.df[res.df$year==y,avars] <- res$mean
}

write.csv(res.df, file="white-hake-catch-at-age-gulf-package-smoothed.csv")
