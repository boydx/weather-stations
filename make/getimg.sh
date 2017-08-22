#!/bin/bash

# Remove old imagery and observations.
rm -f *.gif
rm -f *.png
rm -f *.jpg
rm -f *.txt

#  Create date stamp.
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - http:\/\/www.outrageGIS.com/g' > date.txt
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - outrageGIS.com/g' > date2.txt
date +%l:%M%P\ %a,\ %b\ %d,\ %Y > date.nfo
date | sed 's/$/ - Last 60 minutes - http:\/\/www.outrageGIS.com/g' > date.animation.txt

# Download the latest observations.

wget http://w2.weather.gov/images/jkl/webcam/JKLwebcam000M.jpg
wget http://adds.aviationweather.gov/data/satellite/latest_EVV_vis.jpg
wget http://radar.weather.gov/ridge/Conus/RadarImg/centgrtlakes.gif
wget http://radar.weather.gov/ridge/lite/N0R/JKL_0.png
wget http://www.weather.gov/wwamap/png/US.png
wget http://radar.weather.gov/ridge/Conus/RadarImg/southeast.gif
wget http://radar.weather.gov/lite/N0R/MRX_0.png
wget http://www.wpc.ncep.noaa.gov/sfc/lrgnamsfcwbg.gif
wget http://www.nature.nps.gov/air/webcams/parks/grsmpkcam/grpk.jpg
wget http://www.nature.nps.gov/air/webcams/parks/grsmcam/grsm.jpg
wget http://www.fsvisimages.com/images/photos-main/SHRO1_main.jpg -O SHRO1_1.JPG
wget http://www.fsvisimages.com/images/photos-main/JOKI1_main.jpg -O joki1.jpg
wget "http://forecast.weather.gov/MapClick.php?lat=35.562515939454734&lon=-83.49815368652344&site=mrx&smap=1&unit=0&lg=en&FcstType=text" -O NewFoundGap.txt


