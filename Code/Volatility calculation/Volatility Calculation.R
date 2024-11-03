library(openxlsx)

volatility<-c()

for( i in 1:23){
  datas<- read.xlsx("Enter the location of Commodity daily prices.xlsx", sheet = i)
  datas<-datas[-1,0]
  mat<-matrix(datas[,4],nrow=5)
  
  for(j in 1:ncol(mat)){
    volatility<-append(volatility,sd(mat[,j]))
  }
  
}

Commodities<-c("Cocoa","Coffee","Corn","Cotton","Oats","Orange juice","Soybean meals",
                  "Soybeans", "Sugar","Wheat",
                  "WTI oil","Heating oil","Gasoline",
                  "Feeder cattle","Lean hog","Live cattle",
                  "Copper","Gold","Silver","Platinum","Palladium","Aluminium","Nickel")

volatility<-matrix(volatility,ncol=23)
write.csv(volatility,"Enter the location where you want to save the commodity volatility data")