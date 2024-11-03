library(stochvol)
library(tseries)
datas <- read.csv("Enter the location of day_idd.csv",header=F)
volatility<-c()
for(i in 1:ncol(datas)){
  vdatas<-svsample(as.numeric(datas[,i],draws=10000,burnin=5000))
  volatility<-append(volatility,vdatas$summary$sd[,4])
}
volatility<-matrix(volatility,ncol=ncol(datas))

