---?image=presentation/img/st-b.svg
<h3 style="color:rgba(255,255,255,0.2)">Presentation @</h3>
## boyd.xyz/w
### [repo](https://github.com/boydx/weather-stations)

---?image=https://farm6.staticflickr.com/5688/23373057330_7c3e0cba0c_h.jpg&opacity=30
## Weather mapping in 
# HD
### a season of Kentucky sunsets

---?image=presentation/img/p002.jpg&opacity=40
## Weather mapping for
# Funsies

---?image=presentation/img/p003.jpg
## Satellites, surveillance, chemtrails


---?image=presentation/img/p005.jpg&opacity=70
## Automating 
### the capture, storage, and dissemination of webcam and satellite imagery

---?image=presentation/img/p004.jpg&opacity=20
## Open source CLI mapping 

---
## Outline
@ul[squares]
* Project origins
* GOES-16
* An archive of imagery?
@ulend

---?image=https://outragegis.com/weather/img/animation/170201/LookRock-small.gif&opacity=20
# 2007
@ul[squares]
* Year of the webcam
* Collect images every 15 minutes
* Put them on a web page
@ulend

---?image=presentation/img/p006.jpg

---?image=presentation/img/p006.jpg&opacity=25
## Great Smoky Mountain National Park
[weather station](https://www.outragegis.com/weather/grsm/)

---?image=https://i1.wp.com/www.outragegis.com/weather/090309/LookRock-090309-moonrise.jpg&opacity=30
## Tech stack
@ul[squares]
* Ubuntu Linux
* CLI text utilities, [grep](https://www.pcre.org/original/doc/html/pcregrep.html), [sed](https://www.gnu.org/software/sed/manual/sed.html), etc.
* [Imagemagick](https://www.imagemagick.org/)
* task scheduler [cron](https://en.wikipedia.org/wiki/Cron)
* Brute force scraping
@ulend

---
## Brief example
@[2]
@[3]
@[4]
@[5]
```bash
#!/bin/bash
rm -f *.jpg 
date +%l:%M%P\ %a,\ %b\ %d,\ %Y > date.txt
wget http://www.nature.nps.gov/air/webcams/parks/grsmcam/grsm.jpg
montage -geometry +0+0 -background white -label "@date.txt" grsm.jpg LookRock.jpg
```

---?image=https://www.outragegis.com/weather/img/LookRock.jpg&size=contain

---?image=https://www.outragegis.com/weather/img/LookRock.jpg&opacity=30&size=contain
# Yesterday 
## in the Great Smokies

---
## Date stamp
```bash
#!/bin/bash
t=$(date +%H%M) # 24-hour time with minutes, e.g., 1530
cp LookRock.jpg yesterday/LookRock-$t.jpg
```

---
<iframe width="100%" height="500px" src="https://www.outragegis.com/weather/img/animation/yesterday"><iframe>


---
## Make yesterday
@[2]
@[3]
@[4]
@[5]
@[6-7]
```bash
#!/bin/bash
x=$(ls -1) #list one file per line
convert -delay 50 $x -loop 0 LookRock.gif
date +%0y%m%d > ../date.txt # 190215
mkdir ../$(cat date.txt)
cp -r ../yesterday/ ../$(cat date.txt)/
```

---?image=presentation/img/p007.jpg&size=contain

---?image=presentation/img/p007.jpg&size=contain&opacity=25
## Archive
@ul[squares]
* Keep three years online
* One year approximately 8 GB
* [yesterdays archived](https://www.outragegis.com/weather/img/animation/)
* ~775 (x3) sunsets (and sunrises)
@ulend


---
## Problems?
@ul[squares]
* HTML scraping is an alley fight 
* Need a new satellite
@ulend

---
```bash
#Brute force! 
curl https://nws.weather.gov/forecast > Smokies.txt
pcregrep -M -A 90 "<style>" Smokies.txt | sed 's_<html><head>__g' | sed 's_font-family: Arial !important;__g' | sed 's_<img src="/images/wtf/12.gif" border=0 height=35 width=30 alt=Print>__g' | sed 's_<img src="_<img src="http://forecast.weather.gov/_g' | sed 's_<a href="showsigwx_<a href="http://forecast.weather.gov/showsigwx_g' | sed 's_table width="800"_table width="100%"_g' | sed 's_<hr><br>__g' | sed 's_<br><br><br><br><br>_<br>_g' > SmokiesForecast.txt
```

---?image=https://www.outragegis.com/weather/img/cuga-vis.jpg

---?image=https://www.outragegis.com/weather/img/cuga-vis.jpg&opacity=25
## Not detailed enough
### We expect more from our data.

---?image=https://www.outragegis.com/weather/img/animation/180621/PurchaseKnob.gif&opacity=20
# 2017
@ul[squares]
* Year of the satellite
* GOES-R => GOES-16 => GOES East
* Live feed and archive [on AWS](https://registry.opendata.aws/noaa-goes/) 
@ulend

---?image=presentation/img/p008.jpg&size=contain

---?image=presentation/img/p008.jpg&size=contain&opacity=30
## $200
Data link with [open source software and hardware](https://pietern.github.io/goestools)

---?image=presentation/img/20190441300_GOES16-ABI-FD-GEOCOLOR-1808x1808.jpg&size=contain

---?image=presentation/img/20190441300_GOES16-ABI-FD-GEOCOLOR-1808x1808.jpg&size=contain&opacity=30
## GOES East
@ul[squares]
* 16 spectral bands
* Red @ 0.31 mi per pixel
* Veggie @ 0.62 mi per pixel
* Blue @ 0.62 mi per pixel
* Not RGB
@ulend

---?image=https://www.nesdis.noaa.gov/sites/default/files/goes_west_goes_east_fleet.png&size=contain


---?image=presentation/img/p009.jpg&opacity=30
## Kentucky's view
@ul[squares]
* [Gray](https://www.outragegis.com/weather/goes16/gray.jpg) (2 MB)
* [Pseudo true-color](https://www.outragegis.com/weather/goes16/rgb.jpg) (500 KB)
* Processed every 15 minutes
@ulend

---?image=presentation/img/p010.jpg&opacity=30
## Additional tech
@ul[squares]
* [GDAL](https://www.gdal.org)
* [AWS CLI](https://aws.amazon.com/cli/)
* [Miniconda](https://docs.conda.io/en/latest/miniconda.html) for conda package manager
@ulend


---
## Bash script
@[73-83]
@[121-122]
@[127-135]
@[137-139]
@[158-161]
```bash
#!/bin/bash

#########################################
# LICENSE
# Copyright (C) 2019 Boyd Shearer and Dr. Marcial Garbanzo Salas
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
#########################################

#########################################
# AUTHOR
# This program was created at the University of Kentucky and University of Costa Rica (UCR)
#########################################

#########################################
# REQUIREMENTS
# GDAL 2.3.3, released 2018/12/14 or greater
# ImageMagick 6.7.7-10 2018-09-28 Q16 http://www.imagemagick.org or greater
# aws-cli/1.16.81 Python/3.7.1 Linux/3.13.0-37-generic botocore/1.12.71 or greater
#########################################
#########################################

#########################################
# SET UP ENVIRONMENT
#
source activate geo
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - https:\/\/uky-gis.github.io/g' > date.txt

#########################################

#########################################
# CLEANING FROM PREVIOUS RUNS
#
rm DesiredData.txt
rm FullList.txt
rm all-info.txt
#########################################

echo "GOES16 ABI data downloader"

#########################################
# CONFIGURATION
#
# YEAR OF INTEREST
# YEARS='2018'
YEARS=$(date -u +%Y)

# DAYS OF THE YEAR
# DAYS="340"
DAYS=$(date -u +%j)

# HOUR OF THE DAY
# HOURS="16"
HOURS=$(date -u +%H)

# CHANNELS
# Example: CHANNELS='C01 C02 C03 C04 C05 C06 C07 C08 C09 C10 C11 C12 C13 C14 C15 C16'
CHANNELS='C01 C02 C03'
# CHANNELS='C07 C14 C12'

# ABI PRODUCTS
# Description: https://aws.amazon.com/public-datasets/goes/
# and http://edc.occ-data.org/goes16/getdata/
# Example: PRODUCTS='L1b-RadC L1b-RadF L1b-RadM L2-CMIPC L2-CMIPF L2-CMIPM L2-MCMIPC L2-MCMIPF L2-MCMIPM'
PRODUCTS='L1b-RadC'
#########################################

#########################################
# Get list of remote files available
# PART 1. Obtain full list of files
#
for PRODUCT in $PRODUCTS; do
    for YEAR in $YEARS; do
        for DAY in $DAYS; do
            for HOUR in $HOURS; do
                aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR | awk '{print $4}' >> FullList.txt
                aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR >> all-info.txt
            done
        done
    done
done

#########################################
# PART 2. Select only desired channels
#
for CHANNEL in $CHANNELS; do
    grep $CHANNEL FullList.txt | tail -n 1 >> DesiredData.txt
done
#########################################

#########################################
# PART 3. Loop through list, download data, and apply GDAL processing
#
CURRENT=$(date +%Y%j%H%M)
for x in $(cat DesiredData.txt);

do
    
    FULLNAME=$(echo $x)
    NAME=$(echo $x | cut -d"/" -f5)
    CH=$(echo $NAME | cut -c 19-21)
    
    echo "Processing file $NAME of size $SIZE"
    
    if [ -f $NAME ]; then
        echo "This file exists locally"
        LOCALSIZE=$(du -s $NAME | awk '{ print $1 }')
        if [ $LOCALSIZE ]; then
            echo "The size of the file is not the same as the remote file. Downloading again..."
            aws s3 --no-sign-request cp s3://noaa-goes16/$FULLNAME ./
        else
            echo "The size of the file matches the remote file. Not downloading it again."
        fi
    else
        echo "This file does not exists locally, downloading..."
        aws s3 --no-sign-request cp s3://noaa-goes16/$FULLNAME ./
    fi
    
    # Translate NetCDF format to TIFF
    gdal_translate NETCDF:$NAME:Rad $CH'_'.tif
    
    # Create variable for processing
    i=$CH'_'.tif
    
    # Run image statistics for toning
    echo "*********************************"$i"*********************************"
    gdalinfo -stats $i
    MEAN=$(gdalinfo -stats $i | grep ' Mean=' | cut -d "=" -f 4 | cut -d "," -f 1)
    STD=$(gdalinfo -stats $i | grep ' StdDev=' | cut -d "=" -f 5 | cut -d "," -f 1)
    LO=$(gdalinfo -stats $i | grep ' Minimum=' | cut -d "=" -f 2 | cut -d "," -f 1)
    HI=$(echo "$MEAN + ($STD*3)" | bc)
    echo $i" **** Low: "$LO" **** High: "$HI" ****"
    gdal_translate -ot Byte -of Gtiff -scale $LO $HI 0 255 $i '_scale_'$i
    
    # Project to Web Mercator
    echo $i"**** projecting"
    gdalwarp '_scale_'$i -t_srs EPSG:3857 -s_srs '+proj=geos +lon_0=-75 +h=35786023 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs  +sweep=x' -r cubic -of Gtiff  '_prj_'$i
    
    # Clip to area of interest
    echo $i"**** clipping"
    gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'$i '_crop_'$i
    
    # If high resolution red band, then resize for RGB and export high resolution gray
    if [ $i = "C02_.tif" ]; then
        gdalwarp -ts 1540 1339 -r cubic '_crop_'$i 'final/rgb/_crop_'$i
        convert '_crop_'$i -auto-level '_level_'$i
        composite -gravity center us_goes16_lg.png '_level_'$i '_overlay_'$i
        montage -geometry +0+0 -background white -label "@date.txt" '_overlay_'$i gray.jpg
    else
        gdalwarp -ts 1540 1339 -r cubic '_crop_'$i 'final/rgb/_crop_'$i
    fi
done
# End PART 3.
# #########################################

#########################################
# PART 4. Calculate Green Band  - 30% R, 45% Veggie, 25% B
#
gdal_calc.py -A final/rgb/_crop_C02_.tif -B final/rgb/_crop_C03_.tif -C final/rgb/_crop_C01_.tif --outfile=final/rgb/_green_.tif --calc="(0.3*A)+(0.45*B)+(0.25*C)"

#########################################
# PART 5. Composite pseudo color RGB
#
gdal_merge.py -separate -a_nodata 255 255 255 -of GTiff -o final/rgb.tif --optfile bands.txt
convert final/rgb.tif -auto-level final/rgb_b.jpg
composite -gravity center us_goes16_sm.png final/rgb_b.jpg final/rgb_a.jpg
montage -geometry +0+0 -background white -label "@date.txt" final/rgb_a.jpg rgb.jpg
```

---?image=https://www.outragegis.com/weather/img/animation/180616/GrsmVis-large.gif&opacity=20
# Demo?

---?image=presentation/img/rgb.jpg&opacity=20
## Conclusion on Kentucky's view
@ul[squares]
* [Gray](https://www.outragegis.com/weather/goes16/gray.jpg) & [Pseudo true-color](https://www.outragegis.com/weather/goes16/rgb.jpg)
* Computationally intense (mostly in conversion to TIFF)
* Using only portion of data
@ulend

---?image=https://www.outragegis.com/weather/img/animation/180616/PurchaseKnob-small.gif&opacity=20
## Opportunity
@ul[squares]
* Create a raster tileset for contiguous states
* Wrap processes in Python script
* Pause at time of Kentucky's sunset
@ulend

---
## Python
@[25-30]
@[32-36]
@[38-42]
@[60-63]
@[138-140]
@[159-162]
@[198-201]
```python
###############################################
#  Make RGB GOES 16 tileset every 15 minutes. #
###############################################

###############################################
# LICENSE
# Copyright (C) 2019 Boyd Shearer and Dr. Marcial Garbanzo Salas
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
###############################################

###############################################
# AUTHOR
# This program was created at the University of Kentucky and University of Costa Rica (UCR)
###############################################

###############################################
# REQUIREMENTS
# GDAL 2.3.3, released 2018/12/14 or greater
# ImageMagick 6.7.7-10 2018-09-28 Q16 http://www.imagemagick.org or greater
# aws-cli/1.16.81 Python/3.7.1 Linux/3.13.0-37-generic botocore/1.12.71 or greater
###############################################

# Import modules
from datetime import datetime
from astral import Astral
import subprocess
import json
import pytz

# Get current time in Kentucky
datetime.now()
dt = datetime.now()
dt = pytz.timezone('US/Eastern').localize(dt)
print(dt)

# Set location and find local sun times
city_name = 'Louisville'
a = Astral()
a.solar_depression = 'civil'
city = a[city_name]

# Get UTC time for GOES16 harvest
years = datetime.utcnow().strftime("%Y")
days = datetime.utcnow().strftime("%j")
hours = datetime.utcnow().strftime("%H")
minutes = datetime.utcnow().strftime("%M")

# Make label
label = f"{years}_d{days}_h{hours}_m{minutes}"

# Set GEOS 16 projection
proj = "'+proj=geos +lon_0=-75 +h=35786023 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs  +sweep=x'"

# Set products desired
products = "L1b-RadC"

# Select bands based on time
sun = city.sun(date=datetime.now(), local=True)
if (dt > sun["sunrise"]) and (dt < sun["sunset"]):
    channels = "C01 C02 C03"
    mode = "day"
elif (dt < sun["sunrise"]):
    channels = "C16"
    mode = "night"
elif (dt > sun["sunset"]):
    channels = "C16"
    mode = "night"
else:
    channels = "C16"
    mode = "night"
    
# Check the details!
print(mode) 
print(f"Time is {mode}: {dt}. Downloading {channels}.")

# Clean before running
shellDelete = f"""
echo "Remove past run..."
rm -v *.tif
rm -v *.xml
rm -v FullList.txt
rm -v all-info.txt
rm -v DesiredData.txt
"""

Delete = subprocess.run(shellDelete, shell=True, stdout=subprocess.PIPE)
print(Delete.stdout.decode('UTF-8'))

# Find the NetCDF files
awk_ = "awk '{print $4}'"
shellGetImg = f"""
for PRODUCT in {products}; do
 for YEAR in {years}; do 
  for DAY in {days}; do 
   for HOUR in {hours}; do                         
    aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR | {awk_} >> FullList.txt 
    aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR >> all-info.txt 
   done
  done
  done
done
for CHANNEL in {channels}; do
 grep $CHANNEL FullList.txt | tail -n 1 >> DesiredData.txt
done
cat DesiredData.txt
"""
GetImg = subprocess.run(shellGetImg, shell=True, stdout=subprocess.PIPE)
print(GetImg.stdout.decode('UTF-8'))

# Downlaod the NetCDF files
shellDownload = f"""
for x in $(cat DesiredData.txt)
do
 FULLNAME=$(echo $x)
 NAME=$(echo $x | cut -d"/" -f5)
 CH=$(echo $NAME | cut -c 19-21)
 echo "************* Downloaded "$NAME": "$CH
 aws s3 --no-sign-request cp s3://noaa-goes16/$FULLNAME ./$CH".nc"
done
"""
Download = subprocess.run(shellDownload, shell=True, stdout=subprocess.PIPE)
print(Download.stdout.decode('UTF-8'))

# Convert to TIFF
for i in channels.split():
    print(f"Translating {i} to GTiff format... ")
    shellTranslate = f"""
    gdal_translate NETCDF:{i}.nc:Rad {i}.tif
    rm {i}.nc
    gdalinfo -stats {i}.tif
    """
    completed = subprocess.run(shellTranslate, shell=True, stdout=subprocess.PIPE)
    print(completed.stdout.decode('UTF-8'))

# Create projected and toned images
for i in channels.split():
    bandinfo = subprocess.run(f"gdalinfo -stats -json {i}.tif", shell=True, stdout=subprocess.PIPE)
    bandmeta = json.loads(bandinfo.stdout.decode('UTF-8'))
    # print(bandmeta)
    hi = bandmeta['bands'][0]['mean'] + (bandmeta['bands'][0]['stdDev']*3)
    lo = bandmeta['bands'][0]['min'] #+ (bandmeta['bands'][0]['stdDev']*0.5)
    print(f"************* For {i} applying minimum: {lo} and maximum: {hi} -- no worries about GDAL errors! *************")
    shellScaleDay = f"""
    gdal_translate -ot Byte -of Gtiff -scale {lo} {hi} 0 255 {i}.tif '_scale_'{i}.tif
    gdalwarp '_scale_'{i}.tif -t_srs EPSG:3857 -s_srs {proj} -r cubic -of Gtiff  '_prj_'{i}.tif
    gdalwarp -cutline us.geojson -crop_to_cutline '_prj_'{i}.tif '_us_'{i}.tif
    gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'{i}.tif '_ky_'{i}.tif
    rm '_scale_'{i}.tif; rm '_prj_'{i}.tif #rm {i}.tif; 
    """
    shellScaleNight = f"""
    gdal_translate -ot Byte -of Gtiff -scale {lo} {hi} 255 0 {i}.tif '_scale_'{i}.tif
    gdalwarp '_scale_'{i}.tif -t_srs EPSG:3857 -s_srs {proj} -r cubic -of Gtiff  '_prj_'{i}.tif
    gdalwarp -cutline us.geojson -crop_to_cutline '_prj_'{i}.tif '_us_'{i}.tif
    gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'{i}.tif '_ky_'{i}.tif
    rm '_scale_'{i}.tif; rm '_prj_'{i}.tif #rm {i}.tif; 
    """
    if mode == "day":
        Scale = subprocess.run(shellScaleDay, shell=True, stdout=subprocess.PIPE)
    else:
        Scale = subprocess.run(shellScaleNight, shell=True, stdout=subprocess.PIPE)
    
    print(Scale.stdout.decode('UTF-8'))
    
# Make tilesets
bands = channels.split()

ratioColor = '"(0.3*A)+(0.45*B)+(0.25*C)"'

if mode == "day":
    print(f"************* Processing day bands for RGB *************")
    shellMergeDay = f"""
    gdalwarp -ts 5158 3222 -r cubic '_us_'{bands[1]}.tif '_resize_'{bands[1]}.tif
    gdal_calc.py -A '_resize_'{bands[1]}.tif -B '_us_'{bands[2]}.tif -C '_us_'{bands[0]}.tif --outfile=_green_.tif --calc={ratioColor} 
    gdal_merge.py -separate -a_nodata 255 255 255 -of GTiff -o _rgb_.tif --optfile bands.txt
    gdal2tiles.py -p mercator -z 0-8 -w all -r average -a 0.0 _rgb_.tif tiles
    """
    Merge = subprocess.run(shellMergeDay, shell=True, stdout=subprocess.PIPE)
else:
    print(f"************* Processing night band for grayscale *************")
    shellMergeNight = f"""
    gdal2tiles.py -p mercator -z 0-8 -w all -r average -a 0.0 '_us_'{bands[0]}.tif tiles
    """
    Merge = subprocess.run(shellMergeNight, shell=True, stdout=subprocess.PIPE)
    
print(Merge.stdout.decode('UTF-8'))

shellTilesProduction = f"""
echo "Added production tiles."
cp -rf tiles/* ~/www/weather/goes16/tiles/
rm -r tiles/*
"""

TilesProduction = subprocess.run(shellTilesProduction, shell=True, stdout=subprocess.PIPE)
print(TilesProduction.stdout.decode('UTF-8'))

if mode == "day":
    print(f"************* Making C02 high res tileset *************")
    shellTilesGrayProduction = f"""
    gdal2tiles.py -p mercator -z 0-9 -w all -r average -a 0.0 _us_C02.tif tilesgray
    cp -rf tilesgray/* ~/www/weather/goes16/tilesgray/
    rm -r tilesgray/*
    mv -f _rgb_.tif ~/www/weather/goes16/rgb.tif
    mv -f _us_C02.tif ~/www/weather/goes16/gray.tif
    """
    TilesGrayProduction = subprocess.run(shellTilesGrayProduction, shell=True, stdout=subprocess.PIPE)
    print(TilesProduction.stdout.decode('UTF-8'))
```
---?image=presentation/img/p011.jpg&opacity=20
## Current view
@ul[squares]
* [Updated](https://www.outragegis.com/weather/goes16/map) every 15 minutes
* Make GeoTIFFs available
* Pause at time of [Kentucky's sunset](https://www.outragegis.com/weather/goes16/sunset/190214) 💙
@ulend


---?image=https://www.outragegis.com/weather/img/animation/180616/ColdMountain-small.gif&opacity=20
# 2019
@ul[squares]
* One week of tilesets is 8 GB
* Archive not sustainable
* Year-long animation of Kentucky at sunset
* More practical [teaching opportunity](https://uky-gis.github.io/maps/goes-16/)
@ulend
