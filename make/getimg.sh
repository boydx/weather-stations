cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/make
rm -f lrgnamsfcwbg.gif
rm -f JKL_0.png
rm -f US.png
rm -f centgrtlakes.gif
rm -f southeast.gif
rm -f MRX_0.png
rm -f latest_EVV_vis.jpg
rm -f grpk.jpg
rm -f grsm.jpg
# rm -f grsmF.jpg
rm -f SHRO1_1.JPG
rm -f joki1.jpg
rm -f awcsfcwbg.gif
rm -f SHRO1.jpg
rm -f JOKI1.jpg
rm -f JKLwebcam000M.jpg
rm -f WeOBV-large.gif
rm -f JOKI1_main.jpg
wget http://w2.weather.gov/images/jkl/webcam/JKLwebcam000M.jpg
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - http:\/\/www.outrageGIS.com/g' > date.txt
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - outrageGIS.com/g' > date2.txt
date +%l:%M%P\ %a,\ %b\ %d,\ %Y > date.nfo
date | sed 's/$/ - Last 60 minutes - http:\/\/www.outrageGIS.com/g' > date.animation.txt
wget http://adds.aviationweather.gov/data/satellite/latest_EVV_vis.jpg
wget http://radar.weather.gov/ridge/Conus/RadarImg/centgrtlakes.gif
# wget http://www.crh.noaa.gov/ridge/lite/NCR/JKL_loop.gif
# wget http://radar.weather.gov/ridge/Conus/Loop/centgrtlakes_loop.gif
# wget http://www.crh.noaa.gov/ridge/lite/N0R/JKL_0.png
wget http://radar.weather.gov/ridge/lite/N0R/JKL_0.png
wget http://www.weather.gov/wwamap/png/US.png
wget http://radar.weather.gov/ridge/Conus/RadarImg/southeast.gif
wget http://radar.weather.gov/lite/N0R/MRX_0.png
# wget http://www.crh.noaa.gov/ridge/lite/N0R/MRX_0.png
# wget http://www.hpc.ncep.noaa.gov/sfc/awcsfcwbg.gif
wget http://www.wpc.ncep.noaa.gov/sfc/lrgnamsfcwbg.gif
# wget http://www.hpc.ncep.noaa.gov/sfc/lrgnamsfcwbg.gif
# wget http://webcam.srs.fs.fed.us/SHRO1_1.JPG
# wget http://www.fsvisimages.com/images/photos-main/joki1.jpg
wget http://www.nature.nps.gov/air/webcams/parks/grsmpkcam/grpk.jpg
# wget http://www.nature.nps.gov/air/webcams/parks/grsmcam/grsmF.jpg
wget http://www.nature.nps.gov/air/webcams/parks/grsmcam/grsm.jpg
rm -f NewFoundGap.txt
# wget "http://forecast.weather.gov/MapClick.php?lat=35.562515939454734&lon=-83.49815368652344&site=mrx&smap=1&unit=0&lg=en&FcstType=text" -O NewFoundGap.txt
wget http://www.fsvisimages.com/images/photos-main/SHRO1_main.jpg -O SHRO1_1.JPG
wget http://www.fsvisimages.com/images/photos-main/JOKI1_main.jpg -O joki1.jpg
