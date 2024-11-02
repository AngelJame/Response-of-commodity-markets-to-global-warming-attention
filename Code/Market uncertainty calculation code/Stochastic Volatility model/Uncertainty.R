library(stochvol)
library(tseries)
datas <- read.csv("请输入文件路径\\idd_all.csv",header=F)
volatility<-c()
for(i in 1:ncol(datas)){
  
  #vdatas<-datas[,i]
  #print(adf.test(vdatas))
  
  #第一步，准备数据，这里原文是将价格数据demean处理，而我们这里检验平稳性即可
  #该方法是核心方法，本文将先验参数全部设置为默认
  #             取10000个数据，舍弃前1000个，超参数设置默认数值·
  vdatas<-svsample(as.numeric(datas[,i],draws=10000,burnin=5000))
  volatility<-append(volatility,vdatas$summary$sd[,4])
}
volatility<-matrix(volatility,ncol=ncol(datas))

