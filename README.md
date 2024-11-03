# <p align="center">Data and Code for "Response of commodity markets to global warming attention"</p>
## 1.Data
  
(1) `Commodity daily prices.xlsx` records daily prices of 23 commodities including Cocco, Coffee, Corn, etc. from *Datastream database*.  
  
(2) `Commdity weekly prices.xlsx` records weekly price data for commodities, which is composed by filtering daily prices every Friday from `Commdity daily prices.xlsx`. The returns of commodities in the papers' Table 2 are calculated based on this data through papers' equation (2)。  

(3) `Global abnormal attention index.xlsx` records the global abnormal surface temperature from *Berkeley Earth Temperature (https://berkeleyearth.org/data/)*.  

(4) `Global warming attention index` records the internet search index of topic 'global warming' from *Google Trend (https://trends.google.com/trends)*.  

(5) `Related topics weekly index.xlsx` records the internet search index of ten topics closely related to global warming from *Google Trend (https://trends.google.com/trends)*. Ten topcis are  greenhouse effect, greenhouse gas, carbon dioxide, heat wave, extreme weather, ocean acidification,  sea level rise, water scarcity, climate change adaptation, climate change mitigation.  

(6) `Weekly control variables.xlsx` records weekly data of four control variables, including Economic Policy Uncertainty Index (gepu), the Index of Global Real Economic Activity (igrea), nominal exchange rate index (exchange), and the Geopolitical Risk Index (gpr).  

## 2.Code    
### Volatility calculation    

(1) `Volatility Calculation.R` is an R language program that calculates the volatility of the commodity markets, the data needed for this program is */Data/Commdity daily prices.xlsx*.   

### Market uncertainty calculation code    

The calculation of the commodity market uncertainty (UNC) involves two steps. The first step uses a generalised dynamic factor model (GDFM) to remove the predictable factors in the commodity markets from commodity returns. This step obtains the residuals of commodity returns over different periods, representing the unique volatility behaviour of the return of a particular commodity. Considering the time-varying characteristics of returns, the second step adopts the Monte Carlo method to estimate the stochastic volatility model. This captures the random walk characteristics of returns, resulting in the commodity market uncertainty index.  
    
#### Generalised Dynamic Factor model  
  
(1) `day_return.xlsx` is the daily commodity market returns, which is summarized by `/Data/Commodity daily prices.xlsx`.  

(2) Firstly, we import `day_return.xlsx` into **Matlab software** in the numerical matrix format.  

(3) Secondly, `numfactors.m` is used to obtain the relationship (see the following figure) between the number of dynamic factors and information criteria by setting the threshold value of q_max=10, and using the default settings for the rest of parameters. The q-value (red curve) corresponding to the second interval where Sc (blue curve) is 0 is the optimal number of dynamic factors. Therefore, the optimal number of dynamic factors is 1 in this work. 
![image](https://github.com/user-attachments/assets/5ca8a9ee-d56f-4b93-9cc8-b208b82909f2)    

(4) Thirdly, `Launch.m` is used to obtain the optimal number of static factors. We set threshold kmax as 10, and the number of static factors is determined to be 5 based on the PC1 or PC2 information criteria.   

(5) Finally, we use `gdfm_onesided.m` (setting the number of dynamic factors to 1 and the number of static factors to 5), to obtain the residual series of returns of commodities by removing the effects of predictable factors on daily commodity returns.  

#### Stochastic Volatility model  

(1) `day_idd.csv` is the return result of `gdfm_onesided.m` program.
(2) `Uncertainty.R` file is an R language program, using Monte Carlo method to obtain commodity market uncertainty index.  
    
### GMM-PVAR model    

(1) `pvar2014.zip` is the necessary Stata package to implement the GMM-PVAR model. We need to download and extract it to the installation directory of the **Stata software**.     

(2) `GMM-PVAR` is a Stata program, which is also the key program for this paper. We can obtain shocks of global warming attention to commodity market (see Fig. 3-8 in Paper), responses of commodity markets to global warming attention shocks introducing control variables (see Fig. 9), responses of commodity markets to global abnormal temperature shocks (see Fig. 11-12), and responses of commodity markets to ten topics colsely to global warming (see Supplementary Figure S2-S11).   

(3) `PVAR for commodtiy markets.dta`, `PVAR for the agricultural market.dta`, `PVAR for the fossil energy market.dta`, `PVAR for the livestock market.dta`, `PVAR for the metal market.dta` are data for `GMM-PVAR`, which are compiled from `/Data/Commodity weekly prices.xlsx`, `Global abnormal weekly temperature.xlsx`, `Global warming attention index.xlsx`, `Global warming attention index.xlsx`, `Weekly control variables.xlsx`, volatility data calculated by `/Code/Volatility calculation/Volatility Calculation.R`, and market uncertainty data calculated by bulk programs in `/Code/Market uncertainty calculation code/`.  

### Fixed-effects ordinary least squares estimation of panel vector autoregression model   

(1) `Data for PVAR_FEOLS.csv` is the commodity markets data for `PVAR_FEOLS.R`, including Commodity names (newid), Time (newtime), the first difference of global warming attention (DSVI), the returns of commodity (RET), the volatility of commodity (VOL), the first difference of commdity markets uncertainty (DUNC). RET, VOL and DUNC are compiled from `/Code/GMM-PVAR model/PVAR for commodity markets.dta`.  

(2) `PVAR_FEOLS.R` is an R Language program to obtain responses of the commodity markets to global warming attention shocks analysed using FEOLS-PVAR (see Fig. 13 in paper).
