##固定效应OLS面板VAR代码
##FEOLS-PVAR

#1.关键包
#1.Key Package
library(panelvar)

#2.读取数据
#2.Read Data
pdata<-read.csv("the location of Data for PVAR_FEOLS",header=T)
pdata=na.omit(pdata)

#3.初始化信息- 变量信息；大宗商品名称
#3.Set variable information
vars<-c("RET","VOL","DUNC")
ari<-c("Cocoa","Coffee","Corn","Cotton","Oats","Orange juice","Soybean meals","Soybeans","Sugar","Wheat")
ene<-c("Gasoline","Heating oil","WTI oil")
liv<-c("Feeder cattle","Lean hog","Live cattle")
met<-c("Aluminium","Copper","Gold","Nickel","Palladium","Platinum","Silver")
all<-c("Cocoa","Coffee","Corn","Cotton","Oats","Orange juice","Soybean meals","Soybeans","Sugar","Wheat",
       "Gasoline","Heating oil","WTI oil",
       "Feeder cattle","Lean hog","Live cattle",
       "Aluminium","Copper","Gold","Nickel","Palladium","Platinum","Silver")

#4.Specify the lag length (The optimal lag order of FEOLS-PVAR is consistent with the benchmark analysis)
#Note: The optimal lag order of the whole commodity market is 3, 1, 3; 
#      the optimal lag order of the agricultural market is 2, 1, 2; 
#      the optimal lag order of the fossil energy market is 1, 3, 1; 
#      the optimal lag order of the livestock products market is 1, 1, 1; 
#      the optimal lag order of the metal market is 1, 1, 1.
lags<-c(1,1,1)

#5.绘图上下5%error band
#5.Using bootstrap depict 5% error band
for (i in 1:3){
  PlotORIF(lags[i],vars[i],met)
}


#bootstrap 
PlotORIF<-function(lag,var,commodity){
  #number of iterations
  ite=100
  #step
  nhead=9
  
  #Sample size and conduct sampling based on it
  size=length(commodity)
  
  oirfs<-c()
  for(it in 1:ite){
    newids=ceiling(runif(size*2,0,size))
    
    newpdata<-pdata[which(pdata$newid==commodity[newids[1]]),]
    newpdata$newid=1
    
    for(i in 2:length(newids)){
      data<-pdata[which(pdata$newid==commodity[newids[i]]),]
      data$newid=i
      newpdata<-rbind(newpdata,data)
    }
    oirfs<-append(oirfs,oirf(pvarfeols(dependent_vars=c("DSVI",var),lags=lag,data=newpdata,panel_identifier=c("newid","newtime")),n.ahead = nhead)$DSVI[,2])
  }
  
  oirf_mat<-matrix(oirfs,nrow=nhead)
  means<-c()
  low<-c()
  high<-c()
  for(i in 1:nrow(oirf_mat)){
    means<-append(means,mean(oirf_mat[i,]))
    low<-append(low,quantile(oirf_mat[i,],probs=0.05))
    high<-append(high,quantile(oirf_mat[i,],probs=0.95))
  }
  print(means)
  print(low)
  print(high)
}
