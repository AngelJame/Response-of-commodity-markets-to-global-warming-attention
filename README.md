# <p align="center">Response of commodity markets to global warming attention</p>

## 1.Data
  
(1) `Commodity daily prices.xlsx` records daily prices of 23 commodities including Cocco, Coffee, Corn, etc. from *Datastream database*.  
  
(2) `Commdity weekly prices.xlsx` records weekly price data for commodities, which is composed by filtering daily prices every Friday from `Commdity daily prices.xlsx`. The return of commodity markets in the papers' Table 2 are calculated based on this data through equation (2)。  

(3) `Global abnormal attention index.xlsx` records the global abnormal surface temperature from *Berkeley Earth Temperature (https://berkeleyearth.org/data/)*.  

(4) `Global warming attention index` records the internet search index of topic 'global warming' from *Google Trend (https://trends.google.com/trends)*.  

(5) `Related topics weekly index.xlsx` records the internet search index of ten topics closely related to global warming from *Google Trend (https://trends.google.com/trends)*. Ten topcis are  greenhouse effect, greenhouse gas, carbon dioxide, heat wave, extreme weather, ocean acidification,  sea level rise, water scarcity, climate change adaptation, climate change mitigation.  

(6) `Weekly control variables.xlsx` records weekly data of four control variables, including Economic Policy Uncertainty Index (gepu), the Index of Global Real Economic Activity (igrea), nominal exchange rate index (exchange), and the Geopolitical Risk Index (gpr).  

## 2.Code    
### Volatility calculation  
(1) `Volatility Calculation.R`
### GMM-PVAR model  
(1) `pvar2014.zip` is the necessary Stata package to implement the GMM-PVAR model. We need to download and extract it to the installation directory of the Stata software.     

(2) `GMM-PVAR`   

