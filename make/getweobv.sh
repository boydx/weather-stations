cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/make
rm -f noaa.gif
# wget http://www.hpc.ncep.noaa.gov/noaa/noaa.gif
rm -f past-obs.txt
#wget http://www.srh.noaa.gov/productview.php?pil=MRXRTPMRX
wget "http://forecast.weather.gov/product.php?site=NWS&product=RTP&issuedby=MRX" -O past-obs.txt
rm -f NewFoundGap.txt
rm -f RRG.txt
rm -f CaveRun.txt
rm -f BigSouth.txt
rm - WestSmokies.txt
wget "http://forecast.weather.gov/MapClick.php?lat=35.562674197206285&lon=-83.49793910980225&site=mrx&unit=0&lg=&FcstType=text" -O  NewFoundGap.txt
wget "http://forecast.weather.gov/MapClick.php?lat=37.78156937014928&lon=-83.6909294128418&site=jkl&unit=0&lg=&FcstType=text" -O RRG.txt
wget "http://forecast.weather.gov/MapClick.php?lat=38.0934982133674&lon=-83.51832389831543&site=jkl&unit=0&lg=&FcstType=text" -O CaveRun.txt
wget "http://forecast.weather.gov/MapClick.php?lat=36.47786112505502&lon=-84.66817617416382&site=jkl&unit=0&lg=&FcstType=text" -O BigSouth.txt
wget "http://forecast.weather.gov/MapClick.php?lat=35.634976650677295&lon=-83.62380981445312&site=gsp&unit=0&lg=&FcstType=text" -O  WestSmokies.txt
