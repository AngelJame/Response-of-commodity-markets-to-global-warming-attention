use "enter the location of data, for example, C:\Users\27195\Desktop\PVAR for commodtiy markets.dta",clear

encode id ,gen(newid)
encode day ,gen(newtime)
xtset newid newtime	

//using first order difference to google search index
//Robustness 1: When you are focusing on abnormal temperature, modify the code as 'rename temp Ab_Temp', and replace all the 'DSVI' with Ab_Temp 
//Robustness 2: When you are focusing on related topics, change 'gsvi' to e.g. 'gsvi_greenhouse_effect'
gen DSVI=d.gsvi

//Pre-processing of commodity returns
gen lnprice=log(price)*100
gen RET=d.lnprice
winsor2 RET,replace cut(1,99) by(newid)

//Pre-processing of commodity volatility
rename vol VOL
winsor2 VOL, replace cut(0,99) by(newid)

//Pre-processing of commodity market uncertainty
gen DUNC=d.unc*100
winsor2 DUNC, replace cut(0,99) by(newid)


//Pre-processing or control Variables:
//exchange: nominal exchange rate index constructed by Martínez-García et al. 
//igrea: the Index of Global Real Economic Activity (IGREA), developed by Kilian and Zhou
//gepu: Economic Policy Uncertainty Index
//gpr: Geopolitical Risk Index
gen rate=d.exchange
gen digrea=d.igrea
gen dgepu=d.gepu
gen dgpr=d.gpr

//Determine the optimal lag order
pvarsoc  DSVI RET, maxlag(4)
pvarsoc DSVI VOL,maxlag(4) 
pvarsoc DSVI DUNC,maxlag(4)

//Obtain results on the impact of global warming attention on commodity returns
pvar2 DSVI RET, lags(1)
//Robustness 3: when you focusing on introducing control variables, please use the following codes 
pvar2 DSVI RET, exog(rate digrea dgepu dgpr) lags(1)

estimate store estpvar
pvarirf, oirf porder(DSVI RET) iter(200) dots step(8)//you can set the iter more than 200 to obtain more credible results


//Obtain results on the impact of global warming attention on commodity volatility
pvar2 DSVI VOL, lags(1) 
estimates store estpvar
pvarirf, oirf porder(DSVI VOL) iter(200) dots step(8) 

//Obtain results on the impact of global warming attention on commodity market uncertainty
pvar2 DSVI DUNC,lag(1)
estimates store estpvar
pvarirf, oirf porder(DSVI DUNC) iter(200) dots step(8) 


